From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 Mar 2011 10:38:13 +0000
Subject: [PATCH 1/4] ARM i.MX: Move gpio initialization to SoC specific
	files
In-Reply-To: <20110303103434.GI29521@pengutronix.de>
References: <1299063683-24903-1-git-send-email-s.hauer@pengutronix.de>
	<1299063683-24903-2-git-send-email-s.hauer@pengutronix.de>
	<20110303102904.GC13179@n2100.arm.linux.org.uk>
	<20110303103434.GI29521@pengutronix.de>
Message-ID: <20110303103813.GD13179@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 03, 2011 at 11:34:34AM +0100, Sascha Hauer wrote:
> On Thu, Mar 03, 2011 at 10:29:04AM +0000, Russell King - ARM Linux wrote:
> > On Wed, Mar 02, 2011 at 12:01:20PM +0100, Sascha Hauer wrote:
> > > diff --git a/arch/arm/mach-imx/mm-imx1.c b/arch/arm/mach-imx/mm-imx1.c
> > > index 378c61b..8613e44 100644
> > > --- a/arch/arm/mach-imx/mm-imx1.c
> > > +++ b/arch/arm/mach-imx/mm-imx1.c
> > > @@ -23,6 +23,8 @@
> > >  
> > >  #include <mach/common.h>
> > >  #include <mach/hardware.h>
> > > +#include <mach/gpio.h>
> > 
> > linux/gpio.h
> 
> I guessed that you would say that. I used mach/gpio.h intentionally
> because I don't need the gpio functions but the
> DEFINE_IMX_GPIO_PORT_IRQ_HIGH macro from this header. Should I use
> linux/gpio.h anyway?

Hmm.  As that's all you want, I guess you should stick with mach/gpio.h
here.
