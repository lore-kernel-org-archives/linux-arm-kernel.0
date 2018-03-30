From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 30 Mar 2018 18:44:13 +0900
Subject: [PATCH 2/3] clk: uniphier: add SATA clock control support
In-Reply-To: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1522403054-18691-1-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <1522403054-18691-3-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock control for SATA controller on UniPhier SoCs. This adds
support for PXs2, LD20 and PXs3.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index d539c82..7d66dfb 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -112,6 +112,8 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
 	UNIPHIER_PRO4_SYS_CLK_USB3(15, 1),
+	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x2104, 18),
+	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x2104, 19),
 	UNIPHIER_PRO4_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
@@ -160,6 +162,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	/* The document mentions 0x2104 bit 18, but not functional */
 	UNIPHIER_CLK_GATE("usb30-phy", 16, NULL, 0x2104, 19),
 	UNIPHIER_CLK_GATE("usb31-phy", 20, NULL, 0x2104, 20),
+	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x2104, 22),
 	UNIPHIER_PRO5_SYS_CLK_AIO(40),
 	{ /* sentinel */ }
 };
@@ -257,6 +260,9 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_CLK_GATE("usb31-phy0", 20, NULL, 0x210c, 17),
 	UNIPHIER_CLK_GATE("usb31-phy1", 21, NULL, 0x210c, 19),
 	UNIPHIER_CLK_GATE("pcie", 24, NULL, 0x210c, 3),
+	UNIPHIER_CLK_GATE("sata0", 28, NULL, 0x210c, 7),
+	UNIPHIER_CLK_GATE("sata1", 29, NULL, 0x210c, 8),
+	UNIPHIER_CLK_GATE("sata-phy", 30, NULL, 0x210c, 21),
 	/* CPU gears */
 	UNIPHIER_CLK_DIV4("cpll", 2, 3, 4, 8),
 	UNIPHIER_CLK_DIV4("spll", 2, 3, 4, 8),
-- 
2.7.4
