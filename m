From: broonie@sirena.org.uk (Mark Brown)
Date: Thu, 29 Sep 2011 13:50:36 +0100
Subject: Long stalls during boot with -next
Message-ID: <20110929125035.GA2085@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since Tuesday I've been experiencing stalls on boot with -next kernels.
The boot appears to proceed normally but there appears to be a good ten
second delay somewhere around the late_initcall() stage with no
indication in the logs:

[    3.110000] regulator_init_complete: PVDD_1V2: disabling
[    3.120000] input: gpio-keys as /devices/platform/gpio-keys.0/input/input5
[    3.120000] wm831x-rtc wm831x-rtc.10: hctosys: unable to read the hardware clock
[   13.690000] kjournald starting.  Commit interval 5 seconds
[   13.690000] EXT3-fs (mmcblk0p2): warning: maximal mount count reached, running e2fsck is recommended

(which happens before or at about the time console output starts
appearing, I'd expect it to appear much earlier).  I've had a poke
around and I didn't spot anything yet, none of the development I've
noticed going on recently looks suspicious.
