From: redhatter@gentoo.org (Stuart Longland)
Date: Thu, 9 Sep 2010 10:02:45 +1000
Subject: Voltage/current/sensor monitoring interface and Wiegand
Message-ID: <20100909000245.GK14056@atomos.longlandclan.yi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

I'm currently writing a driver for an in-house developed sensor
controller device.  This device communicates via I?C, and functions as a
multi-function device incorporating:

- Touchscreen controller
- Keypad/Button controller
- LED driver
- Voltage/current monitor
- Temperature sensor monitor
- Light sensor monitor
- PIR (motion) detection monitor
- Communications interface (for slow serial links like Wiegand)

Our target is a Ka-Ro TX27 module, running their supplied kernel
(2.6.28)... however I'm not afraid to backport things from the latest
kernel, or to forward port any changes for mainline kernel inclusion.
(I've already got an experimental patchset that gets these things
booting kernel 2.6.34.)

The first three on this list, I've got settled pretty nicely using
existing interfaces.  The things I'm not sure about, are the remaining
interfaces, and how to best write a driver for them.

How are voltage *monitors* normally written?  (note, not voltage
*regulators*... this thing does not alter the voltage rails.)  I tried
to make sense of lm-sensors, but that seems very ad-hoc (maybe I missed
some document that explains it) to me.  It's hard to be clear on what is
the *right* way to report a voltage or current reading to userspace.

For the temperature and light sensing... temperature sensors certainly
exist in the PC world, and maybe I should look closely at how they are
normally done, but I wasn't sure about the light sensor.  I was thinking
maybe an input device with some new absolute value reported?

Likewise with the PIR sensor, I notice there's a "gesture" input
(MSC_GESTURE)... seems appropriate?  Or am I barking up the wrong tree?

The other feature is for things like Wiegand... Looking around I cannot
see any interface in the Linux kernel for Wiegand interfaces.

<http://en.wikipedia.org/wiki/Wiegand_protocol>

Given the likely use of embedded Linux in security systems, it makes
sense to come up with a suitable interface out in the open, rather than
everyone coming up with their own device-specific interfaces.

Apologies if this has been asked before, but I've looked around and
haven't seen anything... so I figured before I get too deep into this,
I'd enquire about the Right Way it should be done. ;-)

Regards,
-- 
Stuart Longland (aka Redhatter, VK4MSL)      .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

I haven't lost my mind...
  ...it's backed up on a tape somewhere.
