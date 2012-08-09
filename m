From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 9 Aug 2012 20:44:05 +0100
Subject: [PATCH 1/8] of/irq: Create stub for of_irq_find_parent when
 !CONFIG_OF
In-Reply-To: <5023E366.9010603@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-2-git-send-email-lee.jones@linaro.org>
 <5023E366.9010603@gmail.com>
Message-ID: <20120809194403.GB9966@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 09, 2012 at 11:20:54AM -0500, Rob Herring wrote:
> On 08/09/2012 10:53 AM, Lee Jones wrote:
> > of_irq_find_parent is a handy function to use outside the confines of
> > the Open Firmware subsystem. One such use-case is when the IRQ Domain
> > wishes to find an IRQ domain for a given device node. Currently it can
> > not take any notice of the 'interrupt-parent' property. Instead it
> > just uses the first IRQ controller as it climbs the Device Tree. If
> > we were to use this as a precursor the resultant controller is more
> > likely to be correct.
> 
> Where are you using this? I don't have all the patches in the series.

Sorry Rob. Here:

https://lkml.org/lkml/2012/8/9/373

> > CC: Rob Herring <rob.herring@calxeda.com>
> > CC: devicetree-discuss at lists.ozlabs.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  include/linux/of_irq.h |    5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/include/linux/of_irq.h b/include/linux/of_irq.h
> > index 1717cd9..b8e2411 100644
> > --- a/include/linux/of_irq.h
> > +++ b/include/linux/of_irq.h
> > @@ -83,6 +83,11 @@ static inline unsigned int irq_of_parse_and_map(struct device_node *dev,
> >  {
> >  	return 0;
> >  }
> > +
> > +static inline void *of_irq_find_parent(struct device_node *child)
> > +{
> > +	return NULL;
> > +}
> >  #endif /* !CONFIG_OF */
> >  
> >  #endif /* __OF_IRQ_H */
> > 
> 

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
