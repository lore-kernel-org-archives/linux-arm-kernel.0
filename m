From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 9 Jul 2012 14:18:27 -0700
Subject: [PATCH 1/3] ARM: clk-imx27: Fix rtc clock id
In-Reply-To: <1341694041-7839-1-git-send-email-festevam@gmail.com>
References: <1341694041-7839-1-git-send-email-festevam@gmail.com>
Message-ID: <20120709141827.14a45a9c.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat,  7 Jul 2012 17:47:19 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> Fix rtc clock id.
> 
> --- a/arch/arm/mach-imx/clk-imx27.c
> +++ b/arch/arm/mach-imx/clk-imx27.c
> @@ -256,7 +256,7 @@ int __init mx27_clocks_init(unsigned long fref)
>  	clk_register_clkdev(clk[gpio_ipg_gate], "gpio", NULL);
>  	clk_register_clkdev(clk[brom_ahb_gate], "brom", NULL);
>  	clk_register_clkdev(clk[ata_ahb_gate], "ata", NULL);
> -	clk_register_clkdev(clk[rtc_ipg_gate], "rtc", NULL);
> +	clk_register_clkdev(clk[rtc_ipg_gate], NULL, "mxc_rtc");
>  	clk_register_clkdev(clk[scc_ipg_gate], "scc", NULL);
>  	clk_register_clkdev(clk[cpu_div], "cpu", NULL);
>  	clk_register_clkdev(clk[emi_ahb_gate], "emi_ahb" , NULL);


When I look at this patch I don't know if it changes the user interface
(does it rename or move sysfs files or contents?) and I don't know
whether the patch fixes serious issues, which would indicate that a
backport into -stable is needed.

So, please read and remember these words: when fixing a bug, always
provide a complete description of that bug.  Most especially, provide a
description of the end-user effects of the bug.
