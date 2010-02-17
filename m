From: oliver@neukum.org (Oliver Neukum)
Date: Wed, 17 Feb 2010 10:15:52 +0100
Subject: USB mass storage and ARM cache coherency
In-Reply-To: <1266397543.16346.264.camel@pasglop>
References: <20100208065519.GE1290@ucw.cz>
	<201002160922.47072.oliver@neukum.org>
	<1266397543.16346.264.camel@pasglop>
Message-ID: <201002171015.52875.oliver@neukum.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 17. Februar 2010 10:05:43 schrieb Benjamin Herrenschmidt:
> > Would you care to elaborate on the exact nature of the bug you are
> > fixing?
> 
> I missed part of this thread, so forgive me if I'm a bit off here, but
> if the problem is indeed I$/D$ cache coherency vs. PIO transfers, then
> this is a long solved issue on other archs such as ppc (and I think
> sparc).

We should have changed the subject line.

There's a second problem. It turns out that on ARM
mapping for DMA must not be done if PIO will be used. Some HCDs
use PIO for some transfers but DMA for others. The generic layer
must learn about this.

	Regards
		Oliver
