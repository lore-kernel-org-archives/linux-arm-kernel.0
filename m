From: linuxzsc@gmail.com (Richard Zhao)
Date: Fri, 28 Jan 2011 20:48:58 +0800
Subject: [PATCH 3/3] ARM: mach-mx5/board-mx53_loco: Remove unused UARTs
In-Reply-To: <1295968115-11447-3-git-send-email-fabio.estevam@freescale.com>
References: <1295968115-11447-1-git-send-email-fabio.estevam@freescale.com>
	<1295968115-11447-2-git-send-email-fabio.estevam@freescale.com>
	<1295968115-11447-3-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110128124858.GC2769@richard-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 25, 2011 at 01:08:35PM -0200, Fabio Estevam wrote:
> On mx53_loco only UART1 is used and its signals go to connector J16.
> 
> Remove UART2 and UART3 as they are not used on this board.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Acked-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx53_loco.c |   24 +-----------------------
>  1 files changed, 1 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
> index cba4cd5..3aefd6d 100644
> --- a/arch/arm/mach-mx5/board-mx53_loco.c
> +++ b/arch/arm/mach-mx5/board-mx53_loco.c
> @@ -41,30 +41,8 @@
>  static iomux_v3_cfg_t mx53_loco_pads[] = {
>  	MX53_PAD_CSI0_DAT10__UART1_TXD_MUX,
>  	MX53_PAD_CSI0_DAT11__UART1_RXD_MUX,
> -
> -	MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX,
> -	MX53_PAD_PATA_DMARQ__UART2_TXD_MUX,
> -	MX53_PAD_PATA_DIOR__UART2_RTS,
> -	MX53_PAD_PATA_INTRQ__UART2_CTS,
> -
> -	MX53_PAD_PATA_CS_0__UART3_TXD_MUX,
> -	MX53_PAD_PATA_CS_1__UART3_RXD_MUX,
> -	MX53_PAD_PATA_DA_1__UART3_CTS,
> -	MX53_PAD_PATA_DA_2__UART3_RTS,
> -
> -};
> -
> -static const struct imxuart_platform_data mx53_loco_uart_data __initconst = {
> -	.flags = IMXUART_HAVE_RTSCTS,
>  };
>  
> -static inline void mx53_loco_init_uart(void)
> -{
> -	imx53_add_imx_uart(0, NULL);
> -	imx53_add_imx_uart(1, &mx53_loco_uart_data);
> -	imx53_add_imx_uart(2, &mx53_loco_uart_data);
> -}
> -
>  static inline void mx53_loco_fec_reset(void)
>  {
>  	int ret;
> @@ -88,7 +66,7 @@ static void __init mx53_loco_board_init(void)
>  {
>  	mxc_iomux_v3_setup_multiple_pads(mx53_loco_pads,
>  					ARRAY_SIZE(mx53_loco_pads));
> -	mx53_loco_init_uart();
> +	imx53_add_imx_uart(0, NULL);
>  	mx53_loco_fec_reset();
>  	imx53_add_fec(&mx53_loco_fec_data);
>  }
> -- 
> 1.6.0.4
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
