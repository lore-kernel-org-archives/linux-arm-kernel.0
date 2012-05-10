From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 14:51:42 +0800
Subject: [PATCH V2 10/11] ARM: imx6q: change clkdev device name from
 xxxx.uart to xxxx.serial
In-Reply-To: <1336563190-19974-11-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
 <1336563190-19974-11-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120510065140.GD17875@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 07:33:09PM +0800, Richard Zhao wrote:
> It's because the dts changed the node name.
> 
Dirk had sent the same patch, but I told him that I will rebase my DT
branch on top Sascha's clk, the issue will be solved by the rebasing,
so I'm not taking the last two patches.

Regards,
Shawn

> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |   20 ++++++++++----------
>  1 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index 096fcfb..4ac1282 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -393,16 +393,16 @@ int __init mx6q_clocks_init(void)
>  	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
>  	clk_register_clkdev(clk[twd], NULL, "smp_twd");
>  	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
> -	clk_register_clkdev(clk[uart_serial], "per", "2020000.uart");
> -	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.uart");
> -	clk_register_clkdev(clk[uart_serial], "per", "21e8000.uart");
> -	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.uart");
> -	clk_register_clkdev(clk[uart_serial], "per", "21ec000.uart");
> -	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.uart");
> -	clk_register_clkdev(clk[uart_serial], "per", "21f0000.uart");
> -	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.uart");
> -	clk_register_clkdev(clk[uart_serial], "per", "21f4000.uart");
> -	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.uart");
> +	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
> +	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
> +	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
> +	clk_register_clkdev(clk[uart_ipg], "ipg", "21e8000.serial");
> +	clk_register_clkdev(clk[uart_serial], "per", "21ec000.serial");
> +	clk_register_clkdev(clk[uart_ipg], "ipg", "21ec000.serial");
> +	clk_register_clkdev(clk[uart_serial], "per", "21f0000.serial");
> +	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.serial");
> +	clk_register_clkdev(clk[uart_serial], "per", "21f4000.serial");
> +	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.serial");
>  	clk_register_clkdev(clk[enet], NULL, "2188000.enet");
>  	clk_register_clkdev(clk[usdhc1], NULL, "2190000.usdhc");
>  	clk_register_clkdev(clk[usdhc2], NULL, "2194000.usdhc");
> -- 
> 1.7.5.4
> 
> 
