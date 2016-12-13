From: joe@perches.com (Joe Perches)
Date: Tue, 13 Dec 2016 10:21:57 -0800
Subject: [PATCH V8 3/3] irqchip: qcom: Add IRQ combiner driver
In-Reply-To: <78bfd90d47200347628f7dd98451122f@codeaurora.org>
References: <1480460259-8585-1-git-send-email-agustinv@codeaurora.org>
 <1480460259-8585-4-git-send-email-agustinv@codeaurora.org>
 <b009635d-8a10-5e22-4438-0019d79d01d3@arm.com>
 <78bfd90d47200347628f7dd98451122f@codeaurora.org>
Message-ID: <1481653317.29291.19.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2016-12-13 at 10:23 -0500, Agustin Vega-Frias wrote:
> On 2016-12-07 13:16, Marc Zyngier wrote:
> > > +	}
> > > +
> > > +	combiner->domain = irq_domain_create_linear(
> > > +		pdev->dev.fwnode, combiner->nirqs, &domain_ops, combiner);
> > 
> > On a single line, please. Do no listen to the checkpatch police that
> > will tell you otherwise. It really hurt my eyes to see this opening
> > bracket and *nothing* after that.
> 
> Will do.

It seems generally preferred to have at least one argument on the
same line as the function being called.

So, here are some options:

Maximally fill the lines to 80 columns with the value being set
and function call while aligning to open parenthesis

	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode,
						    combiner->nirqs,
						    &domain_ops, combiner);

Use a separate line for the function call:

	combiner->domain =
		irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
					 &domain_ops, combiner);

Or just ignore the 80 column limit wherever you deem appropriate.

No single style is universal, use what you think best.

Anyway, long identifiers (24 chars here) make staying within the
"strongly preferred" 80 column limit produce quite silly looking
code.
