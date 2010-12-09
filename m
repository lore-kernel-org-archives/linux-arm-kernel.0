From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 9 Dec 2010 09:52:55 +0100
Subject: [PATCH 1/6] ARM: mx5: use config to define boot related addresses
In-Reply-To: <20101209084430.GS9777@n2100.arm.linux.org.uk>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<20101209070411.GH17441@pengutronix.de>
	<20101209084430.GS9777@n2100.arm.linux.org.uk>
Message-ID: <20101209085255.GS17441@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hell Russell,

On Thu, Dec 09, 2010 at 08:44:30AM +0000, Russell King - ARM Linux wrote:
> On Thu, Dec 09, 2010 at 08:04:11AM +0100, Uwe Kleine-K?nig wrote:
> > > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > > index 9939a19..388d2e8 100644
> > > --- a/arch/arm/mach-mx5/Makefile.boot
> > > +++ b/arch/arm/mach-mx5/Makefile.boot
> > > @@ -1,3 +1,3 @@
> > > -   zreladdr-y	:= 0x90008000
> > > -params_phys-y	:= 0x90000100
> > > -initrd_phys-y	:= 0x90800000
> > > +   zreladdr-$(CONFIG_SOC_IMX51)	:= 0x90008000
> > > +params_phys-$(CONFIG_SOC_IMX51)	:= 0x90000100
> > > +initrd_phys-$(CONFIG_SOC_IMX51)	:= 0x90800000
> > That is one of the places that is not multi-soc capable.  You can make
> > it 66% less worse by just removing params_phys and initrd_phys.
> 
> Which then destroys the ability to use the bootp veneer which combines
> a kernel and initrd.
I am aware of that.  I think it's OK to add the assignments when they
are needed the first time which I don't expect to happen soon if at all.

Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
