From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 1 Jul 2010 10:48:28 +0200
Subject: [PATCH 14/33] Removing dead SDMA_IRAM
In-Reply-To: <3dc9983ca244c19f18da8951444e1cc9fae0226f.1277911346.git.siccegge@cs.fau.de>
References: <cover.1277911345.git.siccegge@cs.fau.de>
	<3dc9983ca244c19f18da8951444e1cc9fae0226f.1277911346.git.siccegge@cs.fau.de>
Message-ID: <20100701084828.GE12115@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 30, 2010 at 05:58:25PM +0200, Christoph Egger wrote:
> SDMA_IRAM doesn't exist in Kconfig, therefore removing all references
> for it from the source code.
> 
> Signed-off-by: Christoph Egger <siccegge@cs.fau.de>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>


> ---
>  arch/arm/plat-mxc/include/mach/mx51.h |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mx51.h b/arch/arm/plat-mxc/include/mach/mx51.h
> index 5aad344..fd5ec07 100644
> --- a/arch/arm/plat-mxc/include/mach/mx51.h
> +++ b/arch/arm/plat-mxc/include/mach/mx51.h
> @@ -149,11 +149,7 @@
>  #define MX51_MXC_DMA_CHANNEL_SSI1_RX	MXC_DMA_DYNAMIC_CHANNEL
>  #define MX51_MXC_DMA_CHANNEL_SSI1_TX	MXC_DMA_DYNAMIC_CHANNEL
>  #define MX51_MXC_DMA_CHANNEL_SSI2_RX	MXC_DMA_DYNAMIC_CHANNEL
> -#ifdef CONFIG_SDMA_IRAM
> -#define MX51_MXC_DMA_CHANNEL_SSI2_TX	(MX51_MXC_DMA_CHANNEL_IRAM + 1)
> -#else				/*CONFIG_SDMA_IRAM */
>  #define MX51_MXC_DMA_CHANNEL_SSI2_TX	MXC_DMA_DYNAMIC_CHANNEL
> -#endif				/*CONFIG_SDMA_IRAM */
>  #define MX51_MXC_DMA_CHANNEL_CSPI1_RX	MXC_DMA_DYNAMIC_CHANNEL
>  #define MX51_MXC_DMA_CHANNEL_CSPI1_TX	MXC_DMA_DYNAMIC_CHANNEL
>  #define MX51_MXC_DMA_CHANNEL_CSPI2_RX	MXC_DMA_DYNAMIC_CHANNEL
> -- 
> 1.7.0.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
