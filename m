From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 29 Sep 2011 12:19:44 -0500
Subject: [PATCH 2/2] ARM: gic: add OF based initialization
In-Reply-To: <1317268436-1613-3-git-send-email-robherring2@gmail.com>
References: <1317268436-1613-1-git-send-email-robherring2@gmail.com>
	<1317268436-1613-3-git-send-email-robherring2@gmail.com>
Message-ID: <20110929171944.GD6800@ponder.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 28, 2011 at 10:53:56PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> This adds ARM gic interrupt controller initialization using device tree
> data.
> 
> The initialization function is intended to be called by of_irq_init
> function like this:
> 
> const static struct of_device_id irq_match[] = {
> 	{ .compatible = "arm,cortex-a9-gic", .data = gic_of_init, },
> 	{}
> };
> 
> static void __init init_irqs(void)
> {
> 	of_irq_init(irq_match);
> }
> 
> Signed-off-by: Rob Herring <rob.herring@calxeda.com>

Looks good.

g.
