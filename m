From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 3 Aug 2016 08:08:00 +0530
Subject: [PATCH 0133/1285] Replace numeric parameter like 0444 with macro
In-Reply-To: <20160802104310.22614-1-baolex.ni@intel.com>
References: <20160802104310.22614-1-baolex.ni@intel.com>
Message-ID: <20160803023800.GU9681@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 02, 2016 at 06:43:10PM +0800, Baole Ni wrote:
> I find that the developers often just specified the numeric value
> when calling a macro which is defined with a parameter for access permission.
> As we know, these numeric value for access permission have had the corresponding macro,
> and that using macro can improve the robustness and readability of the code,
> thus, I suggest replacing the numeric parameter with the macro.

and all the patches I recived have same title.

Please, use subsystem specfic tags and driver names. Also patch title is
not telling me much. Perhpas mentioning that you are fixing module
params hardcoding would be better!

> 
> Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
> Signed-off-by: Baole Ni <baolex.ni@intel.com>
> ---
>  drivers/dma/at_xdmac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
> index 75bd662..3c26e23 100644
> --- a/drivers/dma/at_xdmac.c
> +++ b/drivers/dma/at_xdmac.c
> @@ -314,7 +314,7 @@ static inline u8 at_xdmac_get_dwidth(u32 cfg)
>  };
>  
>  static unsigned int init_nr_desc_per_channel = 64;
> -module_param(init_nr_desc_per_channel, uint, 0644);
> +module_param(init_nr_desc_per_channel, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  MODULE_PARM_DESC(init_nr_desc_per_channel,
>  		 "initial descriptors per channel (default: 64)");
>  
> -- 
> 2.9.2
> 

-- 
~Vinod
