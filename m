From: r-woodruff2@ti.com (Woodruff, Richard)
Date: Fri, 23 Oct 2009 13:35:40 -0500
Subject: [PATCH] Use Normal uncached memory rather than Strongly	Ordered
	on ARMv6+
In-Reply-To: <20091023171227.GA29639@n2100.arm.linux.org.uk>
References: <20091023094121.21605.39568.stgit@pc1117.cambridge.arm.com>
	<20091023100639.GA19437@n2100.arm.linux.org.uk>
	<1256293374.6564.27.camel@pc1117.cambridge.arm.com>
	<20091023103420.GC19437@n2100.arm.linux.org.uk>
	<1256295591.6564.42.camel@pc1117.cambridge.arm.com>
	<20091023113001.GA22853@n2100.arm.linux.org.uk>
	<1256299512.6564.74.camel@pc1117.cambridge.arm.com>
	<20091023123600.GB22853@n2100.arm.linux.org.uk>
	<1256316861.6564.154.camel@pc1117.cambridge.arm.com>
	<20091023171227.GA29639@n2100.arm.linux.org.uk>
Message-ID: <13B9B4C6EF24D648824FF11BE8967162039B4E0379@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> From: Russell King - ARM Linux [mailto:linux at arm.linux.org.uk]
> Sent: Friday, October 23, 2009 12:12 PM

> As far as I'm concerned, we've spent far too long discussing this issue -
> there's nothing really to discuss.  We need dma_alloc_coherent() to use
> its own page protection modifier, which causes it to behave the same as
> dma_alloc_writecombine() on ARMv7, and with the existing behaviour (for
> the time being) on ARMv6 and below.  We should leave pgprot_noncached()
> well alone until we know that its other places need to be changed.

We do have a few ARMv7 versions in the pipeline at various stages. ARM has projected speculative access is going to be an issue and we do believe them.  Any tools which will help here and finding the problems will be useful.  Some of these probably will be internal hack patches.  However, once hardware is fully out there having some conditionals out there would help everyone out.

This week there was some odd coherency issue yet to be explained.  That eventual debug will look at this as one of the angles.

On CortexA8-OMAP3430 in the field, if L2-Speculative access is enabled using AuxCR, defiantly we did run into some issues.  In instance I know about the L2 speculative fetch had some collision with secure protection.  This happened across a SMI to monitor mode.  Perhaps it could have as easily been elsewhere like what will be up coming.

Regards,
Richard W.
