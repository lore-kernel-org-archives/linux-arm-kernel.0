From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 26 Jul 2011 09:44:08 +0200
Subject: [PATCH] ARM: board-mx51_babbage: Fix UART2 registration
In-Reply-To: <1311626791-7197-1-git-send-email-festevam@gmail.com>
References: <1311626791-7197-1-git-send-email-festevam@gmail.com>
Message-ID: <20110726074408.GI20587@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 25, 2011 at 05:46:31PM -0300, Fabio Estevam wrote:
> On MX51 Babbage board the RTS/CTS pins are not used on UART2 port.
> 
> Fix the registration of this port.

Applied.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-mx5/board-mx51_babbage.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/board-mx51_babbage.c
> index 15c6000..62aa2af 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -367,7 +367,7 @@ static void __init mx51_babbage_init(void)
>  					ARRAY_SIZE(mx51babbage_pads));
>  
>  	imx51_add_imx_uart(0, &uart_pdata);
> -	imx51_add_imx_uart(1, &uart_pdata);
> +	imx51_add_imx_uart(1, NULL);
>  	imx51_add_imx_uart(2, &uart_pdata);
>  
>  	babbage_fec_reset();
> -- 
> 1.7.1
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
