From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 18 Jun 2013 21:26:29 +0200
Subject: [PATCH] ARM: i.MX: Register clock i.MX5x wire1 device
In-Reply-To: <1371546536-19386-1-git-send-email-shc_work@mail.ru>
References: <1371546536-19386-1-git-send-email-shc_work@mail.ru>
Message-ID: <20130618192629.GY32299@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 01:08:56PM +0400, Alexander Shiyan wrote:
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  arch/arm/mach-imx/clk-imx51-imx53.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
> index 9afac26..7da8f0d 100644
> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
> @@ -339,6 +339,7 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>  	clk_register_clkdev(clk[epit1_hf_gate], "per", "imx-epit.0");
>  	clk_register_clkdev(clk[epit2_ipg_gate], "ipg", "imx-epit.1");
>  	clk_register_clkdev(clk[epit2_hf_gate], "per", "imx-epit.1");
> +	clk_register_clkdev(clk[owire_gate], NULL, "mxc_w1.0");

Why are you adding platform device clock lookups? You should be using
devicetree.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
