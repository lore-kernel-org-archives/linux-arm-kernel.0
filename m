From: shijie8@gmail.com (Huang Shijie)
Date: Wed,  6 Jun 2012 21:22:58 -0400
Subject: [PATCH v2 2/3] ARM: imx6q: add clock for apbh-dma
In-Reply-To: <1339032179-2732-1-git-send-email-shijie8@gmail.com>
References: <1339032179-2732-1-git-send-email-shijie8@gmail.com>
Message-ID: <1339032179-2732-2-git-send-email-shijie8@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add clock for apbh-dma.

Signed-off-by: Huang Shijie <shijie8@gmail.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index cab02d0..12d9040 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -318,7 +318,7 @@ int __init mx6q_clocks_init(void)
 	clk[ahb]               = imx_clk_busy_divider("ahb",               "periph",      base + 0x14, 10,  3,   base + 0x48, 1);
 
 	/*                                name             parent_name          reg         shift */
-	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "ahb",               base + 0x68, 4);
+	clk[apbh_dma]     = imx_clk_gate2("apbh_dma",      "usdhc3",            base + 0x68, 4);
 	clk[asrc]         = imx_clk_gate2("asrc",          "asrc_podf",         base + 0x68, 6);
 	clk[can1_ipg]     = imx_clk_gate2("can1_ipg",      "ipg",               base + 0x68, 14);
 	clk[can1_serial]  = imx_clk_gate2("can1_serial",   "can_root",          base + 0x68, 16);
@@ -393,6 +393,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[twd], NULL, "smp_twd");
 	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
+	clk_register_clkdev(clk[apbh_dma], NULL, "110000.dma-apbh");
 	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
 	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
 	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
-- 
1.7.4.4
