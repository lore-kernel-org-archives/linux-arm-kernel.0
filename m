From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 9 May 2012 19:33:10 +0800
Subject: [PATCH V2 11/11] ARM: imx6q: change clkdev device name from xxxx.enet
 to xxxx.ethernet
In-Reply-To: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
References: <1336563190-19974-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1336563190-19974-12-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's because the dts changed the node name.

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 4ac1282..cab02d0 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -403,7 +403,7 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[uart_ipg], "ipg", "21f0000.serial");
 	clk_register_clkdev(clk[uart_serial], "per", "21f4000.serial");
 	clk_register_clkdev(clk[uart_ipg], "ipg", "21f4000.serial");
-	clk_register_clkdev(clk[enet], NULL, "2188000.enet");
+	clk_register_clkdev(clk[enet], NULL, "2188000.ethernet");
 	clk_register_clkdev(clk[usdhc1], NULL, "2190000.usdhc");
 	clk_register_clkdev(clk[usdhc2], NULL, "2194000.usdhc");
 	clk_register_clkdev(clk[usdhc3], NULL, "2198000.usdhc");
-- 
1.7.5.4
