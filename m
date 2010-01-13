From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Jan 2010 19:02:26 +0000
Subject: [PATCH] Offer 'uncacheable memory' as DMA coherent memory for
	ARMv6
In-Reply-To: <A24693684029E5489D1D202277BE8944514AD02C@dlee02.ent.ti.com>
References: <20100113180327.GE28292@n2100.arm.linux.org.uk>
	<A24693684029E5489D1D202277BE8944514AD02C@dlee02.ent.ti.com>
Message-ID: <20100113190226.GF28292@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2010 at 12:22:11PM -0600, Aguirre, Sergio wrote:
> (Replacing linux-arm-kernel at lists.arm.linux.org.uk with linux-arm-kernel at lists.infradead.org, as I got a SMTP error: "550 Please direct your message to the new mailing lists on lists.infradead.org")

Oops.

> > +config ARM_DMA_MEM_BUFFERABLE
> > +	bool "Use non-cacheable memory for DMA" if CPU_V6 && !CPU_V7
> > +	default y
> 
> Perhaps you meant here:
> 
> default y if CPU_V6 && !CPU_V7

No - default y if CPU_V6 || CPU_V7 - we need it enabled for V7 CPUs.
