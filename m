From: arnaud.patard@rtp-net.org (Arnaud Patard (Rtp))
Date: Thu, 27 Jan 2011 14:48:25 +0100
Subject: [PATCH 13/13] ARM i.MX51 efikamx: remove unnecessary
	CONFIG_SERIAL_IMX ifdefs
In-Reply-To: <1296133233-1062-14-git-send-email-s.hauer@pengutronix.de>
	(Sascha Hauer's message of "Thu, 27 Jan 2011 14:00:33 +0100")
References: <1296133233-1062-1-git-send-email-s.hauer@pengutronix.de>
	<1296133233-1062-14-git-send-email-s.hauer@pengutronix.de>
Message-ID: <87aaim8nkm.fsf@lechat.rtp-net.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sascha Hauer <s.hauer@pengutronix.de> writes:

Hi,

> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx5/board-mx51_efikamx.c |   17 +++--------------
>  1 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/board-mx51_efikamx.c b/arch/arm/mach-mx5/board-mx51_efikamx.c
> index b7946f8..e237040 100644
> --- a/arch/arm/mach-mx5/board-mx51_efikamx.c
> +++ b/arch/arm/mach-mx5/board-mx51_efikamx.c
> @@ -121,23 +121,10 @@ static iomux_v3_cfg_t mx51efikamx_pads[] = {
>  };
>  
>  /* Serial ports */
> -#if defined(CONFIG_SERIAL_IMX) || defined(CONFIG_SERIAL_IMX_MODULE)
>  static const struct imxuart_platform_data uart_pdata = {
>  	.flags = IMXUART_HAVE_RTSCTS,
>  };
>  
> -static inline void mxc_init_imx_uart(void)
> -{
> -	imx51_add_imx_uart(0, &uart_pdata);
> -	imx51_add_imx_uart(1, &uart_pdata);
> -	imx51_add_imx_uart(2, &uart_pdata);
> -}
> -#else /* !SERIAL_IMX */
> -static inline void mxc_init_imx_uart(void)
> -{
> -}
> -#endif /* SERIAL_IMX */
> -
>  /* This function is board specific as the bit mask for the plldiv will also
>   * be different for other Freescale SoCs, thus a common bitmask is not
>   * possible and cannot get place in /plat-mxc/ehci.c.
> @@ -320,7 +307,9 @@ static void __init mxc_board_init(void)
>  					ARRAY_SIZE(mx51efikamx_pads));
>  	mx51_efikamx_board_id();
>  	mxc_register_device(&mxc_usbdr_host_device, &dr_utmi_config);
> -	mxc_init_imx_uart();
> +	imx51_add_imx_uart(0, &uart_pdata);
> +	imx51_add_imx_uart(1, &uart_pdata);
> +	imx51_add_imx_uart(2, &uart_pdata);

I'm even wondering if configuring uart 1 and 2 is necessary. afair only
ttymxc0 is really used

Arnaud
