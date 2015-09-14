declare name    "Signal Pusher (mono)";
declare version "0.0.1";
declare author  "Viacheslav Lotsmanov";
declare license "GPLv3 https://raw.githubusercontent.com/unclechu/faust-signal-pusher/master/LICENSE";

import("filter.lib"); // smooth
import("music.lib"); // db2linear

push = vslider("Push[tooltip=Push level]", 0, 0, 100, 0.1)
	: smooth(0.999);
volume = vslider("Volume[tooltip=Volume (dB)]", 0, -90, 12, 1)
	: db2linear
	: smooth(0.999);

ps(s) = s *(1 +(1 - abs(s) : *( push : ^(2) : /(100) )));
process = ps : *(volume);
