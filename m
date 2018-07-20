From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 20 Jul 2018 17:37:36 +0900
Subject: [PATCH 2/2] clk: uniphier: add more USB3 PHY clocks
In-Reply-To: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532075856-1723-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1532075856-1723-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add USB3 PHY clocks where missing.  Use fixed-factor clocks for those
without gating.

For clarification, prefix clock names with 'ss' or 'hs'.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index a582446..1c5a998 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -122,6 +122,9 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_CLK_FACTOR("usb30-hsphy0", 16, "upll", 1, 12),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy0", 17, "ref", 1, 1),
+	UNIPHIER_CLK_FACTOR("usb31-ssphy0", 20, "ref", 1, 1),
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x2104, 18),
 	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x2104, 19),
 	UNIPHIER_PRO4_SYS_CLK_AIO(40),
@@ -173,8 +176,11 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
 	/* The document mentions 0x2104 bit 18, but not functional */
-	UNIPHIER_CLK_GATE("usb30-phy", 16, NULL, 0x2104, 19),
-	UNIPHIER_CLK_GATE("usb31-phy", 20, NULL, 0x2104, 20),
+	UNIPHIER_CLK_GATE("usb30-hsphy0", 16, NULL, 0x2104, 19),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy0", 17, "ref", 1, 1),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy1", 18, "ref", 1, 1),
+	UNIPHIER_CLK_GATE("usb31-hsphy0", 20, NULL, 0x2104, 20),
+	UNIPHIER_CLK_FACTOR("usb31-ssphy0", 21, "ref", 1, 1),
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x2104, 22),
 	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
@@ -235,8 +241,10 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	 * We do not use bit 15 here.
 	 */
 	UNIPHIER_CLK_GATE("usb30", 14, NULL, 0x210c, 14),
-	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 12),
-	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 13),
+	UNIPHIER_CLK_GATE("usb30-hsphy0", 16, NULL, 0x210c, 12),
+	UNIPHIER_CLK_GATE("usb30-hsphy1", 17, NULL, 0x210c, 13),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy0", 18, "ref", 1, 1),
+	UNIPHIER_CLK_FACTOR("usb30-ssphy1", 19, "ref", 1, 1),
 	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 4),
 	UNIPHIER_LD11_SYS_CLK_AIO(40),
 	UNIPHIER_LD11_SYS_CLK_EVEA(41),
@@ -272,11 +280,11 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x210c, 4),	/* =GIO0 */
 	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x210c, 5),	/* =GIO1 */
 	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x210c, 6),	/* =GIO1-1 */
-	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 16),
-	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 18),
-	UNIPHIER_CLK_GATE("usb30-phy2", 18, NULL, 0x210c, 20),
-	UNIPHIER_CLK_GATE("usb31-phy0", 20, NULL, 0x210c, 17),
-	UNIPHIER_CLK_GATE("usb31-phy1", 21, NULL, 0x210c, 19),
+	UNIPHIER_CLK_GATE("usb30-hsphy0", 16, NULL, 0x210c, 16),
+	UNIPHIER_CLK_GATE("usb30-ssphy0", 17, NULL, 0x210c, 18),
+	UNIPHIER_CLK_GATE("usb30-ssphy1", 18, NULL, 0x210c, 20),
+	UNIPHIER_CLK_GATE("usb31-hsphy0", 20, NULL, 0x210c, 17),
+	UNIPHIER_CLK_GATE("usb31-ssphy0", 21, NULL, 0x210c, 19),
 	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 3),
 	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x210c, 7),
 	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x210c, 8),
-- 
2.7.4
