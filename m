From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 29 Dec 2010 16:42:44 +0800
Subject: [PATCH v2 1/8] ARM: mx5: use config to define boot related
	addresses
In-Reply-To: <20101229081419.GM14221@pengutronix.de>
References: <1293607828-21213-1-git-send-email-richard.zhao@freescale.com>
	<20101229081419.GM14221@pengutronix.de>
Message-ID: <20101229084244.GA8701@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 29, 2010 at 09:14:19AM +0100, Uwe Kleine-K?nig wrote:
> On Wed, Dec 29, 2010 at 03:30:23PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> > Because common clock is change, I don't send out mx50 clock and board level code.
> > But sure I tested the patch series using the clock/board code.
> >  arch/arm/mach-mx5/Makefile.boot |    6 +++---
> >  1 files changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/mach-mx5/Makefile.boot b/arch/arm/mach-mx5/Makefile.boot
> > index 9939a19..388d2e8 100644
> > --- a/arch/arm/mach-mx5/Makefile.boot
> > +++ b/arch/arm/mach-mx5/Makefile.boot
> > @@ -1,3 +1,3 @@
> > -   zreladdr-y	:= 0x90008000
> > -params_phys-y	:= 0x90000100
> > -initrd_phys-y	:= 0x90800000
> > +   zreladdr-$(CONFIG_SOC_IMX51)	:= 0x90008000
> > +params_phys-$(CONFIG_SOC_IMX51)	:= 0x90000100
> > +initrd_phys-$(CONFIG_SOC_IMX51)	:= 0x90800000
> I'd prefer to use CONFIG_MACH_MX51 here.
ok

Richard
> 
> Uwe
> 
> -- 
> Pengutronix e.K.                           | Uwe Kleine-K?nig            |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> 
