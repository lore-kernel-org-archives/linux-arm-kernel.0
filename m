From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 15 Sep 2011 09:50:36 +0100
Subject: [PATCH 0/5] GIC OF bindings
In-Reply-To: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110915085036.GB3089@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2011 at 11:31:35AM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This series introduces of_irq_init to scan the device tree for interrupt
> controller nodes and call their init functions in proper order. The GIC
> init function is then called from this function. The platform code then
> looks something like this:
> 
> const static struct of_device_id irq_match[] = {
> 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> 	{}
> };
> 
> static void __init highbank_init_irq(void)
> {
> 	of_irq_init(irq_match);
> }
> 
> The binding for GIC PPIs is now done with a 3rd interrupt cell to specify
> a cpu mask for which cpu the PPI is connected to. This was discussed at LPC
> and suggested by Grant.
> 
> I dropped the public intc_desc struct. The the interrupt controller's node
> and the interrupt parent's node are passed in directly to the controller's
> init function. The linux irq assignment is now done dynamically using
> irq_alloc_descs.

Hi Rob,

This looks really nicely implemented to me.

Reviewed-by: Jamie Iles <jamie@jamieiles.com>

Jamie
