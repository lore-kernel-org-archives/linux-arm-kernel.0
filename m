From: e.habicht@thiesen.com (Erik Habicht)
Date: Tue, 04 Feb 2014 15:57:31 +0100
Subject: Toradex Colibri PXA270 Sound Problem
Message-ID: <52F0FFDB.4020503@thiesen.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hallo List,

we are using a Toradex PXA270 SoC module with a patch to get the Wolfson
WM9715 working on 2.6.37 (2.6.36, 2.6.35, 2.6.27). It works pretty well.

Now i decided to switch to a newer kernel version. I started with 2.6.38
and modified the patch to compile it. The kernel boot to the
system, but only capturing is working. I get no audio output anymore.

In the previous kernel versions i always use the following amixer settings:
amixer set 'Headphone' 100% on
amixer set 'Speaker Mixer PCM' on
amixer set 'Left HP Mixer PCM' on
amixer set 'Right HP Mixer PCM' on

This is the kernel output. It looks like all versions before:

[    8.405110] WM9711/WM9712 SoC Audio Codec 0.4
[    8.457947] pxa2xx_ac97_try_cold_reset: cold reset timeout (GSR=0x44)
[    8.543333] asoc: wm9712-hifi <-> pxa2xx-ac97 mapping ok
[    8.609104] asoc: wm9712-aux <-> pxa2xx-ac97-aux mapping ok
[    8.687232] wm97xx-ts 0-0:wm9712-codec: detected a wm9712 codec
[    8.760968] input: wm97xx touchscreen as
/devices/platform/soc-audio/0-0:wm9712-codec/input/input0
[    8.875466] ALSA device list:
[    8.911416]   #0: Toradex Colibri

I already tried 3.2.y with the same behavior.

Maybe someone can help me to figure out whats going wrong?

I attached the patches i used:
working = patch-2.6.37.y.patch
not working = patch-2.6.38.y.patch

Best regards,

Erik


_______________________________________________________
Registergericht / Court of jurisdiction: Amtsgericht Gie?en HRB 5708
Gesch?ftsf?hrer / Managing Director: Edith Thiesen, J?rgen Thiesen
USt.-Id: DE 175 623 789
Ust.-Nr: 018 246 00743 FA Fulda

Hauptsitz / Headquarters:
Thiesen Hardware & Software Design GmbH / Im Tiegel 9 / 36367 Wartenberg / Germany

-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-2.6.37.y.patch
Type: text/x-patch
Size: 7300 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/d1fce0df/attachment-0002.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: patch-2.6.38.y.patch
Type: text/x-patch
Size: 7556 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/d1fce0df/attachment-0003.bin>
