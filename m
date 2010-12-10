From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 10 Dec 2010 09:00:39 +0100
Subject: [PATCH 1/6] ARM: mx5: use config to define boot related addresses
In-Reply-To: <20101210052143.GA29335@b20223-2.ap.freescale.net>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<20101209070411.GH17441@pengutronix.de>
	<20101209084430.GS9777@n2100.arm.linux.org.uk>
	<20101209085255.GS17441@pengutronix.de>
	<20101209090052.GT9777@n2100.arm.linux.org.uk>
	<20101210052143.GA29335@b20223-2.ap.freescale.net>
Message-ID: <20101210080039.GD17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Richard,

On Fri, Dec 10, 2010 at 01:21:44PM +0800, Richard Zhao wrote:
> On Thu, Dec 09, 2010 at 09:00:52AM +0000, Russell King - ARM Linux wrote:
> > On Thu, Dec 09, 2010 at 09:52:55AM +0100, Uwe Kleine-K?nig wrote:
> > > On Thu, Dec 09, 2010 at 08:44:30AM +0000, Russell King - ARM Linux wrote:
> > > > On Thu, Dec 09, 2010 at 08:04:11AM +0100, Uwe Kleine-K?nig wrote:
> > > > > > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > > > > > index 9939a19..388d2e8 100644
> > > > > > --- a/arch/arm/mach-mx5/Makefile.boot
> > > > > > +++ b/arch/arm/mach-mx5/Makefile.boot
> > > > > > @@ -1,3 +1,3 @@
> > > > > > -   zreladdr-y	:= 0x90008000
> > > > > > -params_phys-y	:= 0x90000100
> > > > > > -initrd_phys-y	:= 0x90800000
> > > > > > +   zreladdr-$(CONFIG_SOC_IMX51)	:= 0x90008000
> > > > > > +params_phys-$(CONFIG_SOC_IMX51)	:= 0x90000100
> > > > > > +initrd_phys-$(CONFIG_SOC_IMX51)	:= 0x90800000
> > > > > That is one of the places that is not multi-soc capable.  You can make
> > > > > it 66% less worse by just removing params_phys and initrd_phys.
> > > > 
> > > > Which then destroys the ability to use the bootp veneer which combines
> > > > a kernel and initrd.
> > > I am aware of that.  I think it's OK to add the assignments when they
> > > are needed the first time which I don't expect to happen soon if at all.
> > 
> > That depends who is trying to use it.  If it's someone who isn't the
> > original platform developer, they may give up with it if the definitions
> > aren't provided.
> Hi uwe,
> 
> IMO, removing params_phys and initrd_phys is just a work around. It's not 
> the final way to fix multi-SoC support. Do you insist on removing it?
no, I don't care much.  I think it will never be used, but go ahead, do
as you prefer.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
