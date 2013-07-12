From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 13 Jul 2013 01:33:01 +0200
Subject: [PATCH] Route kbd LEDs through the generic LEDs layer
In-Reply-To: <20130712124242.GA5876@type>
References: <201011111440.07882.dmitry.torokhov@gmail.com>
 <20110102090935.GV32469@atrey.karlin.mff.cuni.cz>
 <20110102103210.GA25662@core.coreip.homeip.net>
 <20110102225741.GX5480@const.famille.thibault.fr>
 <20110112182702.GA9168@core.coreip.homeip.net>
 <20111114040613.GA4992@type.famille.thibault.fr>
 <20121221003449.GA6999@type.youpi.perso.aquilenet.fr>
 <20130707101028.GD5651@type.youpi.perso.aquilenet.fr>
 <20130712113655.GA4227@amd.pavel.ucw.cz>
 <20130712124242.GA5876@type>
Message-ID: <20130712233301.GA3646@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > This permits to reassign keyboard LEDs to something else than keyboard "leds"
> > > state, by adding keyboard led and modifier triggers connected to a series
> > > of VT input LEDs, themselves connected to VT input triggers, which
> > > per-input device LEDs use by default.  Userland can thus easily change the LED
> > > behavior of (a priori) all input devices, or of particular input devices.
> > 
> > Nice! Leds now have proper /sys interface.
> > 
> > But... I boot up, switch from X to console, press capslock, and no
> > reaction anywhere.
> 
> Is it working without the patch?  Console-setup for instance is known to
> have broken the capslock LED, which is precisely one of the reasons for
> this patch, which will provide console-setup with a way to bring back
> caps lock working properly.

You are right, it was broken before.

> At any rate, please provide way more information about your keyboard
> and LED configuration (output of dumpkeys, dmesg, content of
> /sys/class/leds/*/trigger, etc.), as things are just working fine for me
> (just like it has been for the past two years).

Well... I just verified, and it works "as well as before", which it
should.

> > Note that this is notebook with usb keyboard plugged in (and two
> > monitors), but I believe this worked before...
> 
> Things work fine with my USB keyboard too, is this perhaps using an odd
> driver which would not expose LEDs in a standard way?

No, everything works as well as it did. Feel free to add:

Tested-by: Pavel Machek <pavel@ucw.cz>

Thanks,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
