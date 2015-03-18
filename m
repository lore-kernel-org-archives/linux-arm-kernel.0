From: vinod.koul@intel.com (Vinod Koul)
Date: Wed, 18 Mar 2015 16:51:55 +0530
Subject: [PATCH 2/2 v2] ARM: configs: remove all CONFIG_RCAR_AUDMAC_PP
 from ARM defconfigs
In-Reply-To: <87mw3jf3qe.wl%kuninori.morimoto.gx@renesas.com>
References: <87pp8ff3sb.wl%kuninori.morimoto.gx@renesas.com>
 <87mw3jf3qe.wl%kuninori.morimoto.gx@renesas.com>
Message-ID: <20150318112155.GL32683@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 12:40:11AM +0000, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Renesas R-Car sound (= rsnd) needs 2 DMAC which are called as
> Audio DMAC (= 1st DMAC) and Audio DMAC peri peri (2nd DMAC).
> And rsnd had assumed that 1st / 2nd DMACs are implemented as DMAEngine.
> But, in result of DMA ML discussion, 2nd DMAC was concluded that it is
> not a general purpose DMAC (2nd DMAC is for Device to Device inside
> sound system). Additionally, current DMAEngine can't support Device to
> Device, and we don't have correct DT bindings for it at this point.
> So the easiest solution for it is that move it from DMAEngine to rsnd
> driver.
> Audio DMAC peri peri DMAEngine is no longer needed.
> Remove all CONFIG_RCAR_AUDMAC_PP from ARM defconfigs

This fails for me, I noticed the removal is not present in topc/sh.
What was this patch based on?

-- 
~Vinod
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> v1 -> v2
> 
>  - new patch
> 
>  arch/arm/configs/multi_v7_defconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> index 06075b6..e805984 100644
> --- a/arch/arm/configs/multi_v7_defconfig
> +++ b/arch/arm/configs/multi_v7_defconfig
> @@ -505,7 +505,6 @@ CONFIG_DW_DMAC=y
>  CONFIG_MV_XOR=y
>  CONFIG_TEGRA20_APB_DMA=y
>  CONFIG_SH_DMAE=y
> -CONFIG_RCAR_AUDMAC_PP=m
>  CONFIG_RCAR_DMAC=y
>  CONFIG_STE_DMA40=y
>  CONFIG_SIRF_DMA=y
> -- 
> 1.9.1
> 

-- 
