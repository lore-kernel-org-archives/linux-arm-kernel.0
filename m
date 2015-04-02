From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 2 Apr 2015 13:13:25 +0530
Subject: [PATCH] dma: at_hdmac: use __le32 for dma addresses
In-Reply-To: <1427392929-10578-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1427392929-10578-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <20150402074325.GX7192@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 06:02:09PM +0000, Ben Dooks wrote:
> The at_dmac uses a lli structure with a mix of dma_addr_t and
> __le32 in it. As Russell King pointed out, dma_addr_t could be
> a non 32-bit size depending on the kernel configuration. Change
> all references of this to __le32 to better match the hardware
> representation.
> 
> Note, this does nothing to fix the discussion of dma vs physical
> addresses also brought up during these discussions.
> 
> This patch depends on the __le32 descriptor updates posted
> previously.
Can you please repost the whole series along with dependecies...

-- 
~Vinod

> 
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> --
> CC: Russell King <linux@arm.linux.org.uk>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> CC: Dan Williams <dan.j.williams@intel.com>
> CC: Vinod Koul <vinod.koul@intel.com>
> CC: linux-arm-kernel at lists.infradead.org
> CC: dmaengine at vger.kernel.org
> ---
>  drivers/dma/at_hdmac_regs.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma/at_hdmac_regs.h b/drivers/dma/at_hdmac_regs.h
> index bd4d174..b246beb 100644
> --- a/drivers/dma/at_hdmac_regs.h
> +++ b/drivers/dma/at_hdmac_regs.h
> @@ -167,13 +167,13 @@
>  /* LLI == Linked List Item; aka DMA buffer descriptor */
>  struct at_lli {
>  	/* values that are not changed by hardware */
> -	dma_addr_t	saddr;
> -	dma_addr_t	daddr;
> +	__le32		saddr;
> +	__le32		daddr;
>  	/* value that may get written back: */
>  	__le32		ctrla;
>  	/* more values that are not changed by hardware */
>  	__le32		ctrlb;
> -	dma_addr_t	dscr;	/* chain to next lli */
> +	__le32		dscr;	/* chain to next lli */
>  };
>  
>  /**
> -- 
> 2.1.4
> 

-- 
