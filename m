From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 6 Jul 2012 19:23:58 +0000
Subject: [GIT PULL] imx6 device tree changes for 3.6
In-Reply-To: <20120706054818.GF20503@S2101-09.ap.freescale.net>
References: <20120706054818.GF20503@S2101-09.ap.freescale.net>
Message-ID: <201207061923.59329.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 06 July 2012, Shawn Guo wrote:
> The following changes since commit 6887a4131da3adaab011613776d865f4bcfb5678:
> 
>   Linux 3.5-rc5 (2012-06-30 16:08:57 -0700)
> 
> are available in the git repository at:
>   git://git.linaro.org/people/shawnguo/linux-2.6.git imx/dt-for-3.6

Pulled all five new branches.

It's very cool that you have been able to add support for the
imx23-olinuxino by adding just a dts file.

There was one trivial merge conflict in imx6, see the resolution below.

	Arnd

diff --cc arch/arm/mach-imx/clk-imx6q.c
index abb42e7,0bb8555..cabbbb7
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@@ -391,6 -392,15 +392,12 @@@ int __init mx6q_clocks_init(void
        clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
        clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
        clk_register_clkdev(clk[twd], NULL, "smp_twd");
 -      clk_register_clkdev(clk[usboh3], NULL, "usboh3");
+       clk_register_clkdev(clk[apbh_dma], NULL, "110000.dma-apbh");
+       clk_register_clkdev(clk[per1_bch], "per1_bch", "112000.gpmi-nand");
+       clk_register_clkdev(clk[gpmi_bch_apb], "gpmi_bch_apb", "112000.gpmi-nand");
+       clk_register_clkdev(clk[gpmi_bch], "gpmi_bch", "112000.gpmi-nand");
+       clk_register_clkdev(clk[gpmi_apb], "gpmi_apb", "112000.gpmi-nand");
+       clk_register_clkdev(clk[gpmi_io], "gpmi_io", "112000.gpmi-nand");
        clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
        clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
        clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
