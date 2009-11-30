From: david-b@pacbell.net (David Brownell)
Date: Mon, 30 Nov 2009 12:21:30 -0800
Subject: [PATCH] genirq: warn about IRQF_SHARED|IRQF_DISABLED at the right
	place
In-Reply-To: <1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1259356206-14843-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1259578067-29169-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <200911301221.30601.david-b@pacbell.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 November 2009, Uwe Kleine-K?nig wrote:
> +???????????????if (new->flags & IRQF_DISABLED)
> +???????????????????????pr_warning("IRQ %d/%s: IRQF_DISABLED is not guaranteed "
> +???????????????????????????????????????"on shared IRQs\n", irq, new->name);

This should have copied the original test ... this way,
it's dropping the SHARED constraint, and trying to morph
into a generic "IRQF_DISABLED is eeebil!" test.

If it just moved the original test, I'd have no problem
with the patch.


... although it'd still not address the general mess in
this area, it'd at least not introduce false warnings.
