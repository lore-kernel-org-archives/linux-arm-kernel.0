From: srinidhi.kasagar@stericsson.com (Srinidhi Kasagar)
Date: Mon, 6 May 2013 12:47:34 +0530
Subject: [PATCH 56/63] ARM: ux500: Remove recently unused
 stedma40_xfer_dir enums
In-Reply-To: <1367591569-32197-57-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
 <1367591569-32197-57-git-send-email-lee.jones@linaro.org>
Message-ID: <20130506071733.GA30181@bnru10>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 03, 2013 at 16:32:42 +0200, Lee Jones wrote:
> We're now using the transfer direction definitions provided by the DMA
> sub-system, so the home-brew ones have become obsolete.
> 
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  include/linux/platform_data/dma-ste-dma40.h |   10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/include/linux/platform_data/dma-ste-dma40.h b/include/linux/platform_data/dma-ste-dma40.h
> index 288dc24..54ddca6 100644
> --- a/include/linux/platform_data/dma-ste-dma40.h
> +++ b/include/linux/platform_data/dma-ste-dma40.h
> @@ -77,14 +77,6 @@ enum stedma40_periph_data_width {
>  	STEDMA40_DOUBLEWORD_WIDTH = STEDMA40_ESIZE_64_BIT
>  };
>  
> -enum stedma40_xfer_dir {
> -	STEDMA40_MEM_TO_MEM = 1,
> -	STEDMA40_MEM_TO_PERIPH,
> -	STEDMA40_PERIPH_TO_MEM,
> -	STEDMA40_PERIPH_TO_PERIPH
> -};
> -
> -
>  /**
>   * struct stedma40_half_channel_info - dst/src channel configuration
>   *
> @@ -120,7 +112,7 @@ struct stedma40_half_channel_info {
>   *
>   */
>  struct stedma40_chan_cfg {
> -	enum stedma40_xfer_dir			 dir;
> +	enum dma_transfer_direction		 dir;


Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com>

srinidhi

>  	bool					 high_priority;
>  	bool					 realtime;
>  	enum stedma40_mode			 mode;
> -- 
> 1.7.10.4
> 
