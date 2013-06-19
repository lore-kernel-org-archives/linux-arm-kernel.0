From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 19 Jun 2013 15:02:57 +0800
Subject: [PATCH] irqchip: gic: call gic_cpu_init() as well in
 CPU_STARTING_FROZEN case
In-Reply-To: <20130614123357.GB4489@S2101-09.ap.freescale.net>
References: <1371036627-13529-1-git-send-email-shawn.guo@linaro.org>
 <20130612151748.GC31646@arm.com>
 <20130614123357.GB4489@S2101-09.ap.freescale.net>
Message-ID: <20130619070253.GA3405@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 14, 2013 at 08:33:59PM +0800, Shawn Guo wrote:
> On Wed, Jun 12, 2013 at 04:17:49PM +0100, Catalin Marinas wrote:
> > On Wed, Jun 12, 2013 at 12:30:27PM +0100, Shawn Guo wrote:
> > > diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
> > > index 1760ceb..19ceaa6 100644
> > > --- a/drivers/irqchip/irq-gic.c
> > > +++ b/drivers/irqchip/irq-gic.c
> > > @@ -705,7 +705,7 @@ static int gic_irq_domain_xlate(struct irq_domain *d,
> > >  static int __cpuinit gic_secondary_init(struct notifier_block *nfb,
> > >  					unsigned long action, void *hcpu)
> > >  {
> > > -	if (action == CPU_STARTING)
> > > +	if (action == CPU_STARTING || action == CPU_STARTING_FROZEN)
> > >  		gic_cpu_init(&gic_data[0]);
> > >  	return NOTIFY_OK;
> > >  }
> > 
> > Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> Thomas,
> 
> Can you please send the fix for 3.10?  Or are you fine with that I ask
> arm-soc folks to send it?

Arnd, Olof,

Can you help send the fix for 3.10?

Shawn
