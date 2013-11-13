From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 13 Nov 2013 19:46:18 +0530
Subject: [PATCH 02/13] dma: ste_dma40: Parse flags property for new
 'high priority channel' request
In-Reply-To: <1383732985-18928-3-git-send-email-lee.jones@linaro.org>
References: <1383732985-18928-1-git-send-email-lee.jones@linaro.org>
 <1383732985-18928-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20131113141617.GB8834@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 06, 2013 at 10:16:14AM +0000, Lee Jones wrote:
> This is used for MSP (audio) devices which is about to be fully DT:ed.
> 
> Cc: Vinod Koul <vinod.koul@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Vinod Koul <vinod.koul@intel.com>

--
~Vinod
> ---
>  drivers/dma/ste_dma40.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
> index b8c031b..00a2de9 100644
> --- a/drivers/dma/ste_dma40.c
> +++ b/drivers/dma/ste_dma40.c
> @@ -2409,6 +2409,7 @@ static void d40_set_prio_realtime(struct d40_chan *d40c)
>  #define D40_DT_FLAGS_DIR(flags)        ((flags >> 1) & 0x1)
>  #define D40_DT_FLAGS_BIG_ENDIAN(flags) ((flags >> 2) & 0x1)
>  #define D40_DT_FLAGS_FIXED_CHAN(flags) ((flags >> 3) & 0x1)
> +#define D40_DT_FLAGS_HIGH_PRIO(flags)  ((flags >> 4) & 0x1)
>  
>  static struct dma_chan *d40_xlate(struct of_phandle_args *dma_spec,
>  				  struct of_dma *ofdma)
> @@ -2446,6 +2447,9 @@ static struct dma_chan *d40_xlate(struct of_phandle_args *dma_spec,
>  		cfg.use_fixed_channel = true;
>  	}
>  
> +	if (D40_DT_FLAGS_HIGH_PRIO(flags))
> +		cfg.high_priority = true;
> +
>  	return dma_request_channel(cap, stedma40_filter, &cfg);
>  }
>  
> -- 
> 1.8.1.2
> 

-- 
