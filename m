From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 11 Apr 2016 11:30:23 +0200
Subject: 4.4, 4.6: camera and unlock buttons produce tons of interrupts
 (was Re: N900 sleep mode)
In-Reply-To: <20160407234134.GQ16484@atomide.com>
References: <20160404213056.GA25912@amd> <20160404220748.GA16484@atomide.com>
 <20160405142250.GA6429@amd> <20160405152916.GE16484@atomide.com>
 <20160405205137.GA10196@amd> <20160407174019.GM16484@atomide.com>
 <20160407194828.GA13338@amd> <20160407213229.GO16484@atomide.com>
 <20160407230150.GA16552@amd> <20160407234134.GQ16484@atomide.com>
Message-ID: <20160411093023.GC11814@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > > gzipped config is attached.
> > > > 
> > > > Note that I'm still using NOLO. I enabled the sleep, then went to
> > > > runlevel 1. LEDs still stay on, 55mA power consumption. That was with
> > > > 1 in off_mode.
> > > 
> > > Nothing idling for me with your .config.. And it seems slower to boot
> > > compared to omap2plus_defconfig? Maybe because of the extra GPIO
> > > interrupts?
> > 
> > Extra interrupts only happen when enable_off_mode is 1, so that should
> > not be an issue during boot.
> 
> OK maybe it's just the extra driver probe time then.

Ok, I did try to minimize config differences. I'm still booting from
NOLO. Now I'm doing the tests from init=... boot. idlest1_core
blocking bits says 0042. But the LEDs still don't blink.

I made config with pretty minimal differences from defconfig (making
required drivers =y, lockdep off so that video works).

Do you think you could try with my config?

> # echo 255 > /sys/class/backlight/acx565akm/brightness
> 
> And then the following to blank for idle:
> 
> # echo 1 > /sys/devices/platform/omapfb/graphics/fb0/blank

Yes, I'm doing this, on console.

Thanks and best regards,
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
