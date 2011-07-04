From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 4 Jul 2011 09:40:34 -0600
Subject: [PATCH 1/1] ARM: mxc: Fix gpio interrupts for mx53
In-Reply-To: <20110704075025.GB6069@pengutronix.de>
References: <1309561479-31909-1-git-send-email-troy.kisky@boundarydevices.com>
	<20110704075025.GB6069@pengutronix.de>
Message-ID: <20110704154034.GE29977@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 04, 2011 at 09:50:25AM +0200, Sascha Hauer wrote:
> Grant,
> 
> Just to let you know:
> When this patch hits mainline you will get a merge conflict in
> arch/arm/plat-mxc/gpio.c as this file is deleted in you gpio
> tree. The correct solution is to remove just arch/arm/plat-mxc/gpio.c
> as this issue is fixed in your tree already.
> 
> Sascha

Okay, thanks.

g.

> 
> On Fri, Jul 01, 2011 at 04:04:39PM -0700, Troy Kisky wrote:
> > Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> > ---
> >  arch/arm/plat-mxc/gpio.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/gpio.c b/arch/arm/plat-mxc/gpio.c
> > index 6cd6d7f..1955eeb 100644
> > --- a/arch/arm/plat-mxc/gpio.c
> > +++ b/arch/arm/plat-mxc/gpio.c
> > @@ -336,7 +336,8 @@ int __init mxc_gpio_init(struct mxc_gpio_port *port, int cnt)
> >  		/* its a serious configuration bug when it fails */
> >  		BUG_ON( gpiochip_add(&port[i].chip) < 0 );
> >  
> > -		if (cpu_is_mx1() || cpu_is_mx3() || cpu_is_mx25() || cpu_is_mx51()) {
> > +		if (cpu_is_mx1() || cpu_is_mx3() || cpu_is_mx25()
> > +				|| cpu_is_mx51() || cpu_is_mx53()) {
> >  			/* setup one handler for each entry */
> >  			irq_set_chained_handler(port[i].irq,
> >  						mx3_gpio_irq_handler);
> > -- 
> > 1.7.0.4
> > 
> > 
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
