From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 24 May 2012 19:30:28 +0200
Subject: [PATCH 2/5] ARM: imx6q: add clock for apbh-dma
In-Reply-To: <1337856659-24812-2-git-send-email-b32955@freescale.com>
References: <1337856659-24812-1-git-send-email-b32955@freescale.com>
 <1337856659-24812-2-git-send-email-b32955@freescale.com>
Message-ID: <20120524173028.GD16535@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 24, 2012 at 06:50:56PM +0800, Huang Shijie wrote:
> add the clock for apbh-dma.
> 
> Signed-off-by: Huang Shijie <b32955@freescale.com>
> ---
>  arch/arm/mach-imx/clk-imx6q.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
> index cab02d0..12d9040 100644
> --- a/arch/arm/mach-imx/clk-imx6q.c
> +++ b/arch/arm/mach-imx/clk-imx6q.c
> @@ -318,7 +318,7 @@ int __init mx6q_clocks_init(void)
>  	clk[ahb]               = imx_clk_busy_divider("ahb",               "periph",      base + 0x14, 10,  3,   base + 0x48, 1);
>  
>  	/*                                name             parent_name          reg         shift */
> -	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "ahb",               base + 0x68, 4);
> +	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);

This change looks strange. Is this correct?

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
