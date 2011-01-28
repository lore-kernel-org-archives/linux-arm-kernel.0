From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 28 Jan 2011 20:46:46 +0800
Subject: [PATCH 1/3] ARM: mach-mx5: Fix build for mx53_loco and mx53_smd
In-Reply-To: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110128124646.GA2769@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 01:08:33PM -0200, Fabio Estevam wrote:
> Commit 816ad74 (ARM: i.MX53: Add full iomux support for mx53) renamed some of the pad names.
> 
> Make the changes accordingly so that mx53_loco and mx53_cmd can build without errors.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   25 +++++++++++++------------
>  arch/arm/mach-mx5/board-mx53_smd.c  |   24 ++++++++++++------------
>  2 files changed, 25 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index d1348e0..dadc856 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -39,20 +39,21 @@
>  #define LOCO_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>  
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
> -	MX53_PAD_CSI0_D10__UART1_TXD,
> -	MX53_PAD_CSI0_D11__UART1_RXD,
> -	MX53_PAD_ATA_DIOW__UART1_TXD,
> -	MX53_PAD_ATA_DMACK__UART1_RXD,
> -
> -	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
> -	MX53_PAD_ATA_DMARQ__UART2_TXD,
> -	MX53_PAD_ATA_DIOR__UART2_RTS,
> -	MX53_PAD_ATA_INTRQ__UART2_CTS,
> -
> -	MX53_PAD_ATA_CS_0__UART3_TXD,
> -	MX53_PAD_ATA_CS_1__UART3_RXD,
> -	MX53_PAD_ATA_DA_1__UART3_CTS,
> -	MX53_PAD_ATA_DA_2__UART3_RTS,
> +	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
> +	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
> +	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
> +	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
> +
> +	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
> +	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
> +	MX53_PAD_PATA_DIOR__UART2_RTS,
> +	MX53_PAD_PATA_INTRQ__UART2_CTS,
> +
> +	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
> +	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
> +	MX53_PAD_PATA_DA_1__UART3_CTS,
> +	MX53_PAD_PATA_DA_2__UART3_RTS,
> +
>  };
>  
>  static const struct imxuart_platform_data mx53_loco_uart_data __initconst = {
> diff --git a/arch/arm/mach-mx5/board-mx53_smd.c b/arch/arm/mach-mx5/board-mx53_smd.c
> index 7970f7a..06070c5 100644
> --- a/arch/arm/mach-mx5/board-mx53_smd.c
> +++ b/arch/arm/mach-mx5/board-mx53_smd.c
> @@ -39,20 +39,20 @@
>  #define SMD_FEC_PHY_RST		IMX_GPIO_NR(7, 6)
>  
>  static iomux_v3_cfg_t mx53_smd_pads[] = {
> -	MX53_PAD_CSI0_D10__UART1_TXD,
> -	MX53_PAD_CSI0_D11__UART1_RXD,
> -	MX53_PAD_ATA_DIOW__UART1_TXD,
> -	MX53_PAD_ATA_DMACK__UART1_RXD,
> -
> -	MX53_PAD_ATA_BUFFER_EN__UART2_RXD,
> -	MX53_PAD_ATA_DMARQ__UART2_TXD,
> -	MX53_PAD_ATA_DIOR__UART2_RTS,
> -	MX53_PAD_ATA_INTRQ__UART2_CTS,
> -
> -	MX53_PAD_ATA_CS_0__UART3_TXD,
> -	MX53_PAD_ATA_CS_1__UART3_RXD,
> -	MX53_PAD_ATA_DA_1__UART3_CTS,
> -	MX53_PAD_ATA_DA_2__UART3_RTS,
> +	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
> +	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
> +	MX53_PAD_PATA_DIOW__UART1_TXD_MUX,
> +	MX53_PAD_PATA_DMACK__UART1_RXD_MUX,
> +
> +	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
> +	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
> +	MX53_PAD_PATA_DIOR__UART2_RTS,
> +	MX53_PAD_PATA_INTRQ__UART2_CTS,
> +
> +	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
> +	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
> +	MX53_PAD_PATA_DA_1__UART3_CTS,
> +	MX53_PAD_PATA_DA_2__UART3_RTS,
>  };
>  
>  static const struct imxuart_platform_data mx53_smd_uart_data __initconst = {
> -- 
> 1.6.0.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
