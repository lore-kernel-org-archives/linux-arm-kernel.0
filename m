From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 5 Apr 2016 15:17:04 +0200
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160404220748.GA16484@atomide.com>
References: <20160130221509.GA28644@amd> <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd> <20160201221111.GP19432@atomide.com>
 <20160207212316.GA6147@amd> <20160209172403.GK19432@atomide.com>
 <20160323123801.GC32031@amd> <20160330191208.GW9329@atomide.com>
 <20160404213056.GA25912@amd> <20160404220748.GA16484@atomide.com>
Message-ID: <20160405131704.GA2973@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > 
> > Display off, on wifi:
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> > f7de7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
> > 0000000d 48004a28 (fa004a28) cm_idlest3_core
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> > ffde7ebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00218042
> > 
> > 00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
> > ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
> > 
> > ..so I believe gadget bits are still set.
> 
> Nope, you got PM working now for the USB as it's now ending with 0x42
> instead of 0x62 :) You still have bit 21 blocking, sorry don't
> remember what that one is, but that's in the TRM for idlest1
> register.

Looking more through the registers... GPIO banks seem to be listed in
cm_idlest_per. You mentioned that they should be automatically
controlled? Does that still work when they are exported to the
userspace?

pavel at n900:~$ ls /sys/class/gpio/
export	       gpio177  gpio73  gpio75     gpiochip128  gpiochip32
gpiochip64  unexport
gpio157  gpio70   gpio74  gpiochip0  gpiochip160  gpiochip494
gpiochip96

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
