From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 30 Mar 2018 18:44:12 +0900
Subject: [PATCH 1/3] clk: uniphier: add PCIe clock control support
In-Reply-To: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1522403054-18691-2-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock control for PCIe controller on UniPhier SoCs. This adds
support for Pro5, LD20 and PXs3.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index fa7f2f3..d539c82 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -141,6 +141,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x2108, 2),
 	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
@@ -216,6 +217,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30", 14, NULL, 0x210c, 14),
 	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 12),
 	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 13),
+	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 4),
 	UNIPHIER_LD11_SYS_CLK_AIO(40),
 	UNIPHIER_LD11_SYS_CLK_EVEA(41),
 	UNIPHIER_LD11_SYS_CLK_EXIV(42),
@@ -254,6 +256,7 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb30-phy2", 18, NULL, 0x210c, 20),
 	UNIPHIER_CLK_GATE("usb31-phy0", 20, NULL, 0x210c, 17),
 	UNIPHIER_CLK_GATE("usb31-phy1", 21, NULL, 0x210c, 19),
+	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 3),
 	/* CPU gears */
 	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
 	UNIPHIER_CLK_DIV4("spll", 2, 3, 4, 8),
-- 
2.7.4
