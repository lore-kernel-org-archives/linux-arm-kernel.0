From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 14 Jan 2010 17:53:14 +0000
Subject: [PATCH] Offer 'uncacheable memory' as DMA coherent memory for
	ARMv6
In-Reply-To: <20100113180327.GE28292@n2100.arm.linux.org.uk>
References: <20100113180327.GE28292@n2100.arm.linux.org.uk>
Message-ID: <1263491595.3964.85.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-01-13 at 18:03 +0000, Russell King - ARM Linux wrote:
> ARMv7 uses 'uncacheable normal memory' to implement DMA coherent memory,
> since mapping the same memory as two different types is defined to be
> unpredictable.
> 
> The same is strictly true for ARMv6 as well, although no bad behaviour
> has been observed thus far.  However, we do want to move ARMv6 to be
> architecturally compliant.  The down side is that some drivers may only
> have been tested on ARMv6, and may be missing the necessary barriers to
> make them work.
> 
> So, offer this as a configuration option, defaulting to enabled (to
> encourage drivers to be fixed.)
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Looks ok to me.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

-- 
Catalin
