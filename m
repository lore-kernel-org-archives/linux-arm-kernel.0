From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 26 Apr 2013 21:52:00 +0100
Subject: [PATCH V3] of: Set the DMA mask to 64 bits when dma_addr_t is
 64-bits
In-Reply-To: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
References: <1367008266-1431-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <20130426205159.GA48325@MacBook-Pro.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 26, 2013 at 09:31:06PM +0100, Laura Abbott wrote:
> Currently, of_platform_device_create_pdata always sets the
> coherent DMA mask to 32 bits. On ARM systems without CONFIG_ZONE_DMA,
> arm_dma_limit gets set to ~0 or 0xFFFFFFFFFFFFFFFF on LPAE based
> systems. Since arm_dma_limit represents the smallest dma_mask
> on the system, the default of 32 bits prevents any dma_coherent
> allocation from succeeding unless clients manually set the
> dma mask first. Rather than make every client on an LPAE system set
> the mask manually, account for the size of dma_addr_t when setting
> the coherent mask.
> 
> Signed-off-by: Laura Abbott <lauraa@codeaurora.org>

Looks good.

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
