From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 9 Aug 2010 15:53:49 +0200
Subject: [PATCH 6/8] ARM i.MX3: add dma request defines
In-Reply-To: <1281344743-2029-7-git-send-email-s.hauer@pengutronix.de>
References: <1281344743-2029-1-git-send-email-s.hauer@pengutronix.de>
	<1281344743-2029-7-git-send-email-s.hauer@pengutronix.de>
Message-ID: <20100809135349.GC27747@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 09, 2010 at 11:05:41AM +0200, Sascha Hauer wrote:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/plat-mxc/include/mach/mx31.h |   14 ++++++++++++++
>  arch/arm/plat-mxc/include/mach/mx35.h |   26 ++++++++++++++++++++++++++
>  arch/arm/plat-mxc/include/mach/mx3x.h |   29 +++++++++++++++++++++++++++++
>  3 files changed, 69 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/include/mach/mx31.h b/arch/arm/plat-mxc/include/mach/mx31.h
> index afee3ab..dafe9b9 100644
> --- a/arch/arm/plat-mxc/include/mach/mx31.h
> +++ b/arch/arm/plat-mxc/include/mach/mx31.h
> @@ -197,6 +197,20 @@ static inline void mx31_setup_weimcs(size_t cs,
>  #define MX31_INT_EXT_WDOG	62
>  #define MX31_INT_EXT_TV		63
>  
> +#define MX31_DMA_REQ_SDHC2	21
> +#define MX31_DMA_REQ_SDHC1	20
> +#define MX31_DMA_REQ_FIRI_TX	17
> +#define MX31_DMA_REQ_FIRI_RX	16
> +#define MX31_DMA_REQ_UART4_TX	13
> +#define MX31_DMA_REQ_UART4_RX	12
> +#define MX31_DMA_REQ_CSPI3_TX	11
> +#define MX31_DMA_REQ_CSPI3_RX	10
> +#define MX31_DMA_REQ_UART5_TX	11
> +#define MX31_DMA_REQ_UART5_RX	10
> +#define MX31_DMA_REQ_UART3_TX	 9
> +#define MX31_DMA_REQ_UART3_RX	 8
> +#define MX31_DMA_REQ_SIM	 5
Die w?rde ich andersherum hinschreiben, also aufsteigend nach Wert.

> +
>  #define MX31_PROD_SIGNATURE		0x1	/* For MX31 */
>  
>  /* silicon revisions specific to i.MX31 */
> diff --git a/arch/arm/plat-mxc/include/mach/mx35.h b/arch/arm/plat-mxc/include/mach/mx35.h
> index af3038c..1835a80 100644
> --- a/arch/arm/plat-mxc/include/mach/mx35.h
> +++ b/arch/arm/plat-mxc/include/mach/mx35.h
> @@ -39,6 +39,9 @@
>  #define MX35_SSI2_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x14000)
>  #define MX35_ATA_DMA_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x20000)
>  #define MX35_MSHC1_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x24000)
> +#define MX35_SPDIF_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x28000)
> +#define MX35_ASRC_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x2c000)
> +#define MX35_ESAI_BASE_ADDR			(MX35_SPBA0_BASE_ADDR + 0x34000)
>  #define MX35_FEC_BASE_ADDR		0x50038000
>  #define MX35_SPBA_CTRL_BASE_ADDR		(MX35_SPBA0_BASE_ADDR + 0x3c000)
>  
> @@ -173,6 +176,26 @@
>  #define MX35_INT_EXT_WDOG	62
>  #define MX35_INT_EXT_TV		63
>  
> +#define MX35_DMA_REQ_ASRC_DMA6	41
> +#define MX35_DMA_REQ_ASRC_DMA5	40
> +#define MX35_DMA_REQ_ASRC_DMA4	39
> +#define MX35_DMA_REQ_ASRC_DMA3	38
> +#define MX35_DMA_REQ_ASRC_DMA2	37
> +#define MX35_DMA_REQ_ASRC_DMA1	36
> +#define MX35_DMA_REQ_RSVD3	35
> +#define MX35_DMA_REQ_RSVD2	34
> +#define MX35_DMA_REQ_ESAI_TX	33
> +#define MX35_DMA_REQ_ESAI_RX	32
> +#define MX35_DMA_REQ_IPU	21
> +#define MX35_DMA_REQ_RSVD1	20
> +#define MX35_DMA_REQ_SPDIF_TX	13
> +#define MX35_DMA_REQ_SPDIF_RX	12
> +#define MX35_DMA_REQ_UART3_TX	11
> +#define MX35_DMA_REQ_UART3_RX	10
> +#define MX35_DMA_REQ_MSHC	 5
> +#define MX35_DMA_REQ_DPTC	 1
> +#define MX35_DMA_REQ_DVFS	 1
Diese auch.
> +
>  #define MX35_PROD_SIGNATURE		0x1	/* For MX31 */
>  
>  /* silicon revisions specific to i.MX31 */
> @@ -207,6 +230,9 @@
>  #define MXC_INT_MLB MX35_INT_MLB
>  #define MXC_INT_SPDIF MX35_INT_SPDIF
>  #define MXC_INT_FEC MX35_INT_FEC
> +#define SPDIF_BASE_ADDR MX35_SPDIF_BASE_ADDR
> +#define ASRC_BASE_ADDR MX35_ASRC_BASE_ADDR
> +#define ESAI_BASE_ADDR MX35_ESAI_BASE_ADDR
>  #endif
>  
>  #endif /* ifndef __MACH_MX35_H__ */
> diff --git a/arch/arm/plat-mxc/include/mach/mx3x.h b/arch/arm/plat-mxc/include/mach/mx3x.h
> index 7a356de..a725daf 100644
> --- a/arch/arm/plat-mxc/include/mach/mx3x.h
> +++ b/arch/arm/plat-mxc/include/mach/mx3x.h
> @@ -197,6 +197,35 @@
>  	(((x) - X_MEMC_BASE_ADDR) + X_MEMC_BASE_ADDR_VIRT)
>  
>  /*
> + * DMA request assignments
> + */
> +#define MX3x_DMA_REQ_ECT	31
> +#define MX3x_DMA_REQ_NFC	30
> +#define MX3x_DMA_REQ_SSI1_TX1	29
> +#define MX3x_DMA_REQ_SSI1_RX1	28
> +#define MX3x_DMA_REQ_SSI1_TX2	27
> +#define MX3x_DMA_REQ_SSI1_RX2	26
> +#define MX3x_DMA_REQ_SSI2_TX1	25
> +#define MX3x_DMA_REQ_SSI2_RX1	24
> +#define MX3x_DMA_REQ_SSI2_TX2	23
> +#define MX3x_DMA_REQ_SSI2_RX2	22
> +#define MX3x_DMA_REQ_UART1_TX	19
> +#define MX3x_DMA_REQ_UART1_RX	18
> +#define MX3x_DMA_REQ_UART2_TX	17
> +#define MX3x_DMA_REQ_UART2_RX	16
> +#define MX3x_DMA_REQ_EXTREQ1	15
> +#define MX3x_DMA_REQ_EXTREQ2	14
> +#define MX3x_DMA_REQ_CSPI1_TX	 9
> +#define MX3x_DMA_REQ_CSPI1_RX	 8
> +#define MX3x_DMA_REQ_CSPI2_TX	 7
> +#define MX3x_DMA_REQ_CSPI2_RX	 6
> +#define MX3x_DMA_REQ_ATA_RX	 4
> +#define MX3x_DMA_REQ_ATA_TX	 3
> +#define MX3x_DMA_REQ_ATA_TX_END	 2
> +#define MX3x_DMA_REQ_CCM	 1
> +#define MX3x_DMA_REQ_EXTREQ0	 0
ditto, brauchen wir MX3x_... wirklich?
> +
> +/*
>   * Interrupt numbers
>   */
>  #define MX3x_INT_I2C3		3
> -- 
> 1.7.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
