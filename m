From: marex@denx.de (Marek Vasut)
Date: Tue, 22 May 2012 06:31:28 +0200
Subject: [PATCH v2 06/12] ARM: imx6q: correct device name of usbphy and
 usb controller clock export
In-Reply-To: <1337592237-5090-7-git-send-email-richard.zhao@freescale.com>
References: <1337592237-5090-1-git-send-email-richard.zhao@freescale.com>
 <1337592237-5090-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <201205220631.28739.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Richard Zhao,

We will need similar patch for mx28 I think?

Otherwise
Reviewed-by: Marek Vasut <marex@denx.de>

> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    5 ++++-
>  1 files changed, 4 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 96e9edd..f99509a 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -391,7 +391,10 @@ int __init mx6q_clocks_init(void)
>  	clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
>  	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
>  	clk_register_clkdev(clk[twd], NULL, "smp_twd");
> -	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184000.usb");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
>  	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
>  	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
>  	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");

Best regards,
Marek Vasut
