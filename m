From: appanad@xilinx.com (Appana Durga Kedareswara Rao)
Date: Fri, 19 Oct 2018 10:37:11 +0000
Subject: [PATCH v2 3/4] dmaengine: xilinx_dma: Introduce helper macro for
 preparing dma address
In-Reply-To: <1538241480-13844-4-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
 <1538241480-13844-4-git-send-email-radhey.shyam.pandey@xilinx.com>
Message-ID: <DM5PR02MB21878ECD3C2B2E4535F2244FDCF90@DM5PR02MB2187.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	Thanks for the patch...

> 
> This patch introduces the xilinx_prep_dma_addr_t macro which prepares
> dma_addr_t from hardware buffer descriptor LSB and MSB fields. It will be
> used in simple dma 64-bit programming sequence.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>

Reviewed-by: Appana Durga Kedareswara Rao <appana.durga.rao@xilinx.com>

Regards,
Kedar.

> ---
> Changes for v2:
> New patch- Preparatory change for 4/4 fix.
> ---
>  drivers/dma/xilinx/xilinx_dma.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
> index a37871e..c27ab64 100644
> --- a/drivers/dma/xilinx/xilinx_dma.c
> +++ b/drivers/dma/xilinx/xilinx_dma.c
> @@ -190,6 +190,8 @@
>  /* AXI CDMA Specific Masks */
>  #define XILINX_CDMA_CR_SGMODE          BIT(3)
> 
> +#define xilinx_prep_dma_addr_t(addr)	\
> +	((dma_addr_t)((u64)addr##_##msb << 32 | (addr)))
>  /**
>   * struct xilinx_vdma_desc_hw - Hardware Descriptor
>   * @next_desc: Next Descriptor Pointer @0x00
> --
> 1.7.1
