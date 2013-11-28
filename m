From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 28 Nov 2013 11:27:06 +0530
Subject: [PATCH] dma: mv_xor: remove mv_desc_get_dest_addr()
In-Reply-To: <1385408365-8072-1-git-send-email-jason@lakedaemon.net>
References: <1385408365-8072-1-git-send-email-jason@lakedaemon.net>
Message-ID: <20131128055706.GM8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+ Dan

On Mon, Nov 25, 2013 at 07:39:25PM +0000, Jason Cooper wrote:
> The following commit:
> 
>   54f8d501e842 dmaengine: remove DMA unmap from drivers
> 
> removed the last caller to mv_desc_get_dest_addr(), creating the
> warning:
> 
>   drivers/dma/mv_xor.c:57:12: warning: 'mv_desc_get_dest_addr' defined
>   but not used [-Wunused-function]
> 
> Remove it.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Vinod Koul <vinod.koul@intel.com>

This should go thru Dan's tree

> ---
>  drivers/dma/mv_xor.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
> index 7807f0ef4e20..23bcc9158cbc 100644
> --- a/drivers/dma/mv_xor.c
> +++ b/drivers/dma/mv_xor.c
> @@ -54,12 +54,6 @@ static void mv_desc_init(struct mv_xor_desc_slot *desc, unsigned long flags)
>  	hw_desc->desc_command = (1 << 31);
>  }
>  
> -static u32 mv_desc_get_dest_addr(struct mv_xor_desc_slot *desc)
> -{
> -	struct mv_xor_desc *hw_desc = desc->hw_desc;
> -	return hw_desc->phy_dest_addr;
> -}
> -
>  static void mv_desc_set_byte_count(struct mv_xor_desc_slot *desc,
>  				   u32 byte_count)
>  {
> -- 
> 1.8.4.4
> 

-- 
