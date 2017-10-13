From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 13 Oct 2017 21:54:46 +0900
Subject: [PATCH] clk: uniphier: fix clock data for PXs3
Message-ID: <1507899286-1953-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix reg offsets of USB clocks.

Fixes: 736de651a836 ("clk: uniphier: add PXs3 clock data")
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index acdba08..bea1327 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -312,9 +312,9 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
-	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x2104, 4),	/* =GIO0 */
-	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x2104, 5),	/* =GIO1 */
-	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x2104, 6),	/* =GIO1-1 */
+	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x210c, 4),	/* =GIO0 */
+	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x210c, 5),	/* =GIO1 */
+	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x210c, 6),	/* =GIO1-1 */
 	UNIPHIER_CLK_GATE("usb30-phy0", 16, NULL, 0x210c, 16),
 	UNIPHIER_CLK_GATE("usb30-phy1", 17, NULL, 0x210c, 18),
 	UNIPHIER_CLK_GATE("usb30-phy2", 18, NULL, 0x210c, 20),
-- 
2.7.4
