From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Dec 2010 08:44:30 +0000
Subject: [PATCH 1/6] ARM: mx5: use config to define boot related addresses
In-Reply-To: <20101209070411.GH17441@pengutronix.de>
References: <1291903716-31388-1-git-send-email-richard.zhao@freescale.com>
	<20101209070411.GH17441@pengutronix.de>
Message-ID: <20101209084430.GS9777@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 09, 2010 at 08:04:11AM +0100, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Dec 09, 2010 at 10:08:31PM +0800, Richard Zhao wrote:
> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> > ---
> > This series of patch support mx50 reference design board. I've tested it using
> > initramfs on the board.
> > 
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
> That is one of the places that is not multi-soc capable.  You can make
> it 66% less worse by just removing params_phys and initrd_phys.

Which then destroys the ability to use the bootp veneer which combines
a kernel and initrd.
