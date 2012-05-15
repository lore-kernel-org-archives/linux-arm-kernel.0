From: richard.zhao@freescale.com (Richard Zhao)
Date: Tue, 15 May 2012 21:58:21 +0800
Subject: [PATCH v1 5/7] ARM: imx6q: correct device name of usbphy and usboh3
 clock export
In-Reply-To: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
References: <1337090303-16046-1-git-send-email-richard.zhao@freescale.com>
Message-ID: <1337090303-16046-6-git-send-email-richard.zhao@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 1618989..f7eb965 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -390,7 +390,12 @@ int __init mx6q_clocks_init(void)
 	clk_register_clkdev(clk[gpt_ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	clk_register_clkdev(clk[twd], NULL, "smp_twd");
-	clk_register_clkdev(clk[usboh3], NULL, "usboh3");
+	clk_register_clkdev(clk[usboh3], NULL, "2184000.usboh3");
+	clk_register_clkdev(clk[usboh3], NULL, "2184200.usboh3");
+	clk_register_clkdev(clk[usboh3], NULL, "2184400.usboh3");
+	clk_register_clkdev(clk[usboh3], NULL, "2184600.usboh3");
+	clk_register_clkdev(clk[pll3_usb_otg], NULL, "20c9000.usbphy");
+	clk_register_clkdev(clk[pll3_usb_otg], NULL, "20ca000.usbphy");
 	clk_register_clkdev(clk[uart_serial], "per", "2020000.serial");
 	clk_register_clkdev(clk[uart_ipg], "ipg", "2020000.serial");
 	clk_register_clkdev(clk[uart_serial], "per", "21e8000.serial");
-- 
1.7.5.4
