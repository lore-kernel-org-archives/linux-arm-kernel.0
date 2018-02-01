From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 1 Feb 2018 08:40:29 -0800
Subject: [PATCH] irqchip/gic-v3: Ignore disabled ITS nodes
In-Reply-To: <8e564636-aae3-4fee-a57c-6f1c01529b49@arm.com>
References: <20180129164933.25479-1-sboyd@codeaurora.org>
 <8e564636-aae3-4fee-a57c-6f1c01529b49@arm.com>
Message-ID: <20180201164029.GA23162@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/01, Marc Zyngier wrote:
> On 29/01/18 16:49, Stephen Boyd wrote:
> > @@ -1815,6 +1815,8 @@ static int __init its_of_probe(struct device_node *node)
> >  
> >  	for (np = of_find_matching_node(node, its_device_id); np;
> >  	     np = of_find_matching_node(np, its_device_id)) {
> > +		if (!of_device_is_available(np))
> > +			continue;
> >  		if (!of_property_read_bool(np, "msi-controller")) {
> >  			pr_warn("%s: no msi-controller property, ITS ignored\n",
> >  				np->full_name);
> > 
> 
> Can you also address the same thing in
> drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c?

Sure.

> 
> Do we need a cc to stable for this?
> 

We don't have any dts files with the disabled node in mainline,
so no?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
