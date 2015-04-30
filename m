From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 30 Apr 2015 09:53:40 +0800
Subject: [PATCH RESEND 1/3] clk: mmp: add fixed clock UBS_PLL for pxa910/pxa168
In-Reply-To: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
References: <1430358822-4699-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1430358822-4699-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

USB will drive clock from USB_PLL.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-of-pxa168.c            | 1 +
 drivers/clk/mmp/clk-of-pxa910.c            | 1 +
 include/dt-bindings/clock/marvell,pxa168.h | 1 +
 include/dt-bindings/clock/marvell,pxa910.h | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/clk/mmp/clk-of-pxa168.c b/drivers/clk/mmp/clk-of-pxa168.c
index 5b1810d..01a650e 100644
--- a/drivers/clk/mmp/clk-of-pxa168.c
+++ b/drivers/clk/mmp/clk-of-pxa168.c
@@ -58,6 +58,7 @@ static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
 	{PXA168_CLK_CLK32, "clk32", NULL, CLK_IS_ROOT, 32768},
 	{PXA168_CLK_VCTCXO, "vctcxo", NULL, CLK_IS_ROOT, 26000000},
 	{PXA168_CLK_PLL1, "pll1", NULL, CLK_IS_ROOT, 624000000},
+	{PXA168_CLK_USB_PLL, "usb_pll", NULL, CLK_IS_ROOT, 480000000},
 };
 
 static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
diff --git a/drivers/clk/mmp/clk-of-pxa910.c b/drivers/clk/mmp/clk-of-pxa910.c
index 5e3c80d..cca98ef 100644
--- a/drivers/clk/mmp/clk-of-pxa910.c
+++ b/drivers/clk/mmp/clk-of-pxa910.c
@@ -57,6 +57,7 @@ static struct mmp_param_fixed_rate_clk fixed_rate_clks[] = {
 	{PXA910_CLK_CLK32, "clk32", NULL, CLK_IS_ROOT, 32768},
 	{PXA910_CLK_VCTCXO, "vctcxo", NULL, CLK_IS_ROOT, 26000000},
 	{PXA910_CLK_PLL1, "pll1", NULL, CLK_IS_ROOT, 624000000},
+	{PXA910_CLK_USB_PLL, "usb_pll", NULL, CLK_IS_ROOT, 480000000},
 };
 
 static struct mmp_param_fixed_factor_clk fixed_factor_clks[] = {
diff --git a/include/dt-bindings/clock/marvell,pxa168.h b/include/dt-bindings/clock/marvell,pxa168.h
index 79630b9..84ce5de 100644
--- a/include/dt-bindings/clock/marvell,pxa168.h
+++ b/include/dt-bindings/clock/marvell,pxa168.h
@@ -19,6 +19,7 @@
 #define PXA168_CLK_PLL1_2_1_5		19
 #define PXA168_CLK_PLL1_3_16		20
 #define PXA168_CLK_UART_PLL		27
+#define PXA168_CLK_USB_PLL		28
 
 /* apb periphrals */
 #define PXA168_CLK_TWSI0		60
diff --git a/include/dt-bindings/clock/marvell,pxa910.h b/include/dt-bindings/clock/marvell,pxa910.h
index 719cffb..bea08b6 100644
--- a/include/dt-bindings/clock/marvell,pxa910.h
+++ b/include/dt-bindings/clock/marvell,pxa910.h
@@ -19,6 +19,7 @@
 #define PXA910_CLK_PLL1_2_1_5		19
 #define PXA910_CLK_PLL1_3_16		20
 #define PXA910_CLK_UART_PLL		27
+#define PXA910_CLK_USB_PLL		28
 
 /* apb periphrals */
 #define PXA910_CLK_TWSI0		60
-- 
1.8.3.2
