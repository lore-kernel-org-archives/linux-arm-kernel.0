From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Fri, 23 Mar 2018 14:11:41 +0900
Subject: [PATCH] clk: uniphier: add ethernet clock control support for PXs3
Message-ID: <1521781901-20466-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock control for ethernet controller on PXs3 SoC.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index d244e72..faadd9b 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -233,6 +233,8 @@ const struct uniphier_clk_data uniphier_pxs3_sys_clk_data[] = {
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
+	UNIPHIER_CLK_GATE("ether0", 6, NULL, 0x210c, 9),
+	UNIPHIER_CLK_GATE("ether1", 7, NULL, 0x210c, 10),
 	UNIPHIER_CLK_GATE("usb30", 12, NULL, 0x210c, 4),	/* =GIO0 */
 	UNIPHIER_CLK_GATE("usb31-0", 13, NULL, 0x210c, 5),	/* =GIO1 */
 	UNIPHIER_CLK_GATE("usb31-1", 14, NULL, 0x210c, 6),	/* =GIO1-1 */
-- 
2.7.4
