From: robert.richter@caviumnetworks.com (Robert Richter)
Date: Fri, 18 Sep 2015 10:33:43 +0200
Subject: [PATCH v4 5/5] irqchip, gicv3-its: Workaround for Cavium
 ThunderX errata 22375, 24313
In-Reply-To: <55EDBC19.2010301@arm.com>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-6-git-send-email-rric@kernel.org>
 <55EDBC19.2010301@arm.com>
Message-ID: <20150918083343.GY1820@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07.09.15 17:32:25, Marc Zyngier wrote:
> On 14/08/15 19:28, Robert Richter wrote:

> > +	if (its->flags & ITS_FLAGS_CAVIUM_THUNDERX) {
> > +		/*
> > +		 * erratum 22375: only alloc 8MB table size
> > +		 * erratum 24313: ignore memory access type
> > +		 */
> > +		cache	= 0;
> > +		ids	= 0x13;			/* 20 bits, 8MB */
> > +	} else {
> 
> You can move the typer definition here, as it is only used here.
> 
> > +		cache	= GITS_BASER_WaWb;
> > +		typer	= readq_relaxed(its->base + GITS_TYPER);
> > +		ids	= GITS_TYPER_DEVBITS(typer);
> > +	}

I am dropping this change as this would raise merge conflicts with
others, e.g. KVM patches.

-Robert
