From: Liviu.Dudau@arm.com (Liviu Dudau)
Date: Mon, 1 Dec 2014 11:44:32 +0000
Subject: [PATCH] irqchip: gic: Allow interrupt level to be set for PPIs.
In-Reply-To: <20141201112302.GC3836@n2100.arm.linux.org.uk>
References: <1417197340-27298-1-git-send-email-Liviu.Dudau@arm.com>
 <20141201104145.GY3836@n2100.arm.linux.org.uk>
 <20141201104612.GM828@e106497-lin.cambridge.arm.com>
 <20141201110358.GA3836@n2100.arm.linux.org.uk>
 <547C4ECD.20802@arm.com>
 <20141201112302.GC3836@n2100.arm.linux.org.uk>
Message-ID: <20141201114432.GP828@e106497-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 01, 2014 at 11:23:02AM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 01, 2014 at 11:19:41AM +0000, Marc Zyngier wrote:
> > Hi Russell,
> > 
> > On 01/12/14 11:03, Russell King - ARM Linux wrote:
> > > If all you want to do is to bypass the following check, what's wrong
> > > with actually doing that:
> > > 
> > > -	if (type != IRQ_TYPE_LEVEL_HIGH && type != IRQ_TYPE_EDGE_RISING)
> > > +	if (gicirq >= 32 && type != IRQ_TYPE_LEVEL_HIGH &&
> > > +	    type != IRQ_TYPE_EDGE_RISING)
> > > 		return -EINVAL;
> > > 
> > 
> > I think that will require some additional changes to gic_configure_irq
> > (in irq-gic-common.c).
> 
> I don't think so - gic_configure_irq() will treat it as a no-op as far
> as trying to configure the IRQ settings.

Doesn't that assume then that reset value is correct for the type that
we are trying to program the PPIs?

This is all very academic, as I don't have any real example of a GIC doing
this, but ...

 - if the PPI is set at reset value to be level triggered
 - and we want to set PPIx to be level LOW triggered

with your proposed patch the change will not happen, right?

Best regards,
Liviu

> 
> -- 
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ?\_(?)_/?
