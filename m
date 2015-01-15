From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 15 Jan 2015 15:25:36 +0100
Subject: [PATCH 0/4] Drop legacy support for omap3517
In-Reply-To: <20150113204219.GJ2419@atomide.com>
References: <1421171865-5209-1-git-send-email-tony@atomide.com>
 <10549142.7lWnPtPtZG@wuerfel> <20150113204219.GJ2419@atomide.com>
Message-ID: <20150115142536.GC512@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 13, 2015 at 12:42:20PM -0800, Tony Lindgren wrote:
> * Arnd Bergmann <arnd@arndb.de> [150113 12:27]:
> > On Tuesday 13 January 2015 09:57:41 Tony Lindgren wrote:
> > > 
> > > It seems we can now drop omap3517 legacy booting support to get
> > > a bit closer to making all of omap3 boot in device tree only mode.
> > > 
> > > All these boards have at least minimal support for booting with
> > > device tree, and pretty much anything supported with the legacy
> > > board files can be configured also for device tree based booting
> > > if not done already.
> > 
> > Ah, very nice.
> > 
> > Just out of curiosity, what are the remaining showstoppers for
> > the 3430 and 3530 based boards?
> 
> Not much really. We're now printing a warning to get a people to
> upgrade their systems. So with some boards we need to wait a while.
> 
> Then here are the remaining items that I'm aware of:
> 
> - A regression at least on some n900 with appended DTB not booting
>   properly any longer reported by Pali
> 
> - A regression where the legacy ATAGs don't seem to get properly
>   translated by the uncompress code for atag_rev at least reported
>   by Pali
> 
> - A few missing .dts files for devkit8000, omap3logic, omap3stalker,
>   omap3pandora and omap3touchbook
> 
> Pali and Sebastian probably know best of any other remaining
> issues to drop n900 legacy booting.

Apart from the bugs there is only one feature-wise regression when
the system is booted via DT, which is the accelerometer. I will
(re)send patches for that in the next days.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150115/86546acf/attachment.sig>
