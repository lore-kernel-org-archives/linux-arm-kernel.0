From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 09:03:34 +0800
Subject: [PATCH v6 1/7] ARM: imx6q: correct device name of usbphy and usb
 controller clock export
In-Reply-To: <1342006425-21008-2-git-send-email-richard.zhao@freescale.com>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-2-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712010332.GA6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that the patch subject does not match the content.

Regards,
Shawn

On Wed, Jul 11, 2012 at 07:33:39PM +0800, Richard Zhao wrote:
> Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index cabbbb7..3f5b9d6 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -398,6 +398,10 @@ int __init mx6q_clocks_init(void)
>  	clk_register_clkdev(clk[gpmi_bch], "gpmi_bch", "112000.gpmi-nand");
>  	clk_register_clkdev(clk[gpmi_apb], "gpmi_apb", "112000.gpmi-nand");
>  	clk_register_clkdev(clk[gpmi_io], "gpmi_io", "112000.gpmi-nand");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184000.usb");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184200.usb");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184400.usb");
> +	clk_register_clkdev(clk[usboh3], NULL, "2184600.usb");
>  	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
>  	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
>  	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
> -- 
> 1.7.9.5
> 
> 
