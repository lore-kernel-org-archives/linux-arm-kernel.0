From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 25 Jan 2015 22:22:58 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <201501241300.00723@pali>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <20150113204219.GJ2419@atomide.com>
 <20150115142536.GC512@earth.universe> <201501241300.00723@pali>
Message-ID: <20150125212015.GA14307@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat 2015-01-24 13:00:00, Pali Roh?r wrote:
> On Thursday 15 January 2015 15:25:36 Sebastian Reichel wrote:
> > On Tue, Jan 13, 2015 at 12:42:20PM -0800, Tony Lindgren wrote:
> > > * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > > > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > > > > It seems we can now drop omap3517 legacy booting support
> > > > > to get a bit closer to making all of omap3 boot in
> > > > > device tree only mode.
> > > > > 
> > > > > All these boards have at least minimal support for
> > > > > booting with device tree, and pretty much anything
> > > > > supported with the legacy board files can be configured
> > > > > also for device tree based booting if not done already.
> > > > 
> > > > Ah, very nice.
> > > > 
> > > > Just out of curiosity, what are the remaining showstoppers
> > > > for the 3430 and 3530 based boards?
> > > 
> > > Not much really. We're now printing a warning to get a
> > > people to upgrade their systems. So with some boards we
> > > need to wait a while.
> > > 
> > > Then here are the remaining items that I'm aware of:
> > > 
> > > - A regression at least on some n900 with appended DTB not
> > > booting
> > > 
> > >   properly any longer reported by Pali
> > > 
> > > - A regression where the legacy ATAGs don't seem to get
> > > properly
> > > 
> > >   translated by the uncompress code for atag_rev at least
> > >   reported by Pali
> > > 
> > > - A few missing .dts files for devkit8000, omap3logic,
> > > omap3stalker,
> > > 
> > >   omap3pandora and omap3touchbook
> > > 
> > > Pali and Sebastian probably know best of any other remaining
> > > issues to drop n900 legacy booting.
> > 
> > Apart from the bugs there is only one feature-wise regression
> > when the system is booted via DT, which is the accelerometer.
> > I will (re)send patches for that in the next days.
> > 
> > -- Sebastian
> 
> Another regression for DT setup (which does not occur for board code):
> 
> omap_hsmmc driver does not export slot_name sysfs entry because
> it not supported by DT yet. Entry slot_name is used by userspace
> application to determinate if mmc block device is internal eMMC
> memory or external uSD card. So support for this property also in
> DT is needed.
> 
> Here is simple patch which fix this problem:

Thanks!

Does it need line into Documentation/devicetree/ somewhere?

With that,
Acked-by: Pavel Machek <pavel@ucw.cz>

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
