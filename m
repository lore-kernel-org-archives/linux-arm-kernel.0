From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 7 Feb 2016 22:23:16 +0100
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160201221111.GP19432@atomide.com>
References: <20160123121022.GB12497@amd> <20160125163332.GT19432@atomide.com>
 <20160126140010.GA29723@amd> <20160126172527.GY3500@atomide.com>
 <20160130200244.GA30429@amd> <20160130201452.GC30429@amd>
 <20160130221509.GA28644@amd> <20160201181316.GM19432@atomide.com>
 <20160201211736.GA11283@amd> <20160201221111.GP19432@atomide.com>
Message-ID: <20160207212316.GA6147@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > (I assume I have to insmod and rmmod, right? Because powersave is not
> > entered if I simply compile-out usb).
> 
> Depending on what the bootloader does and probably also if
> USB was used during the booting.. So yeah you may need to modprobe
> and then rmmod.
> 
> > Would you have commit ids for those rmmod fixes? It might be good to
> > push them into stable, and I should try again with them applied...
> 
> 055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
> 03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")

Ok, with that, I can insmod and rmmod. But I still get:

00001fff 48005020 (fa005020) cm_idlest_per blocking bits: 0007e000
ffdffebd 48004a20 (fa004a20) cm_idlest1_core blocking bits: 00200042
0000000d 48004a28 (fa004a28) cm_idlest3_core

Best regards,
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
