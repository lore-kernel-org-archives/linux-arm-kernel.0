From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 7 Feb 2016 22:37:20 +0100
Subject: N900 sleep mode (in 4.5-rc0, if that matters)
In-Reply-To: <20160204053518.GP19432@atomide.com>
References: <20160125163332.GT19432@atomide.com> <20160126140010.GA29723@amd>
 <20160126172527.GY3500@atomide.com> <20160130200244.GA30429@amd>
 <20160130201452.GC30429@amd> <20160130221509.GA28644@amd>
 <20160201181316.GM19432@atomide.com> <20160201211736.GA11283@amd>
 <20160201221111.GP19432@atomide.com>
 <20160204053518.GP19432@atomide.com>
Message-ID: <20160207213720.GB6147@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > > No, sorry, that was with 4.4. As you hit "PM regression with commit
> > > 5de85b9d57ab PM runtime re-init in v4.5-rc1", I thought I'd avoid
> > > v4.5-rc. 
> > 
> > OK
> > 
> > > (I assume I have to insmod and rmmod, right? Because powersave is not
> > > entered if I simply compile-out usb).
> > 
> > Depending on what the bootloader does and probably also if
> > USB was used during the booting.. So yeah you may need to modprobe
> > and then rmmod.
> > 
> > > Would you have commit ids for those rmmod fixes? It might be good to
> > > push them into stable, and I should try again with them applied...
> > 
> > 055555fc459 ("usb: musb: core: Fix handling of the phy notifications")
> > 03e43528ab68 ("usb: musb: Fix unbalanced pm_runtime_enable")
> 
> Oh and looks like these two phy-twl4030-phy fixes never got
> merged from thread "[PATCH 0/2] Two phy-twl4030-usb fixes for
> unloading the module":
> 
> phy: twl4030-usb: Relase usb phy on unload
> phy: twl4030-usb: Fix unbalanced pm_runtime_enable on module reload
> 
> I'll resend those. But without those again deeper idle states
> are blocked.. And it could be that n900 needs similar additional
> patches for it's USB PHY as I've tested things so far only with
> phy-twl4030-usb PHY based systems.

I don't get it. I was using

+CONFIG_USB_MUSB_OMAP2PLUS=m
+CONFIG_TWL4030_USB=m

on the n900. Are you suggesting I should be using something else on
the N900? If so, what?

Pali, do you have deeper sleep states working on 4.4 kernel? (Or
anything 4.X?)
									
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
