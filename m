From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Apr 2013 18:58:19 +0100
Subject: [PATCH] of: Set the DMA mask to 64 bits on ARM LPAE systems
In-Reply-To: <51796365.5030405@codeaurora.org>
References: <1366764649-10342-1-git-send-email-lauraa@codeaurora.org>
 <20130425133315.GA7157@localhost.cambridge.arm.com>
 <51796365.5030405@codeaurora.org>
Message-ID: <20130425175819.GF14496@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 25, 2013 at 10:09:57AM -0700, Laura Abbott wrote:
> I thought about this as well but in arch/arm/mm/mm.h:
>
> #ifdef CONFIG_ZONE_DMA
> extern phys_addr_t arm_dma_limit;
> #else
> #define arm_dma_limit ((phys_addr_t)~0)
> #endif
>
> arm_dma_limit is explicitly cast to phys_addr_t, which means that  
> arm_dma_limit will be always be sizeof(phys_addr_t) regardless of  
> sizeof(dma_addr_t).

This is the size of the DMA zone, which controls the _minimum_ DMA mask
that can be used in the system.  DMA masks must always be greater than
this limit.
