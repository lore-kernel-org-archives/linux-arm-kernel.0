From: hayashi.kunihiko@socionext.com (Kunihiko Hayashi)
Date: Mon, 28 Aug 2017 18:57:23 +0900
Subject: [PATCH] clk: uniphier: add ethernet clock control support
Message-ID: <1503914243-24518-1-git-send-email-hayashi.kunihiko@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock control for ethernet controller on Pro4, PXs2, LD11 and LD20.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index 6fcf781..01da141 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -57,6 +57,12 @@
 #define UNIPHIER_PRO4_SYS_CLK_USB3(idx, ch)				\
 	UNIPHIER_CLK_GATE("usb3" #ch, (idx), NULL, 0x2104, 16 + (ch))
 
+#define UNIPHIER_PRO4_SYS_CLK_ETHER(idx)				\
+	UNIPHIER_CLK_GATE("ether", (idx), NULL, 0x2104, 12)
+
+#define UNIPHIER_LD11_SYS_CLK_ETHER(idx)				\
+	UNIPHIER_CLK_GATE("ether", (idx), NULL, 0x210c, 6)
+
 const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 65, 1),		/* 1597.44 MHz */
 	UNIPHIER_CLK_FACTOR("upll", -1, "ref", 6000, 512),	/* 288 MHz */
@@ -81,6 +87,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_LD4_SYS_CLK_NAND(2),
 	UNIPHIER_LD4_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
+	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),			/* HSC, MIO, RLE */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),			/* Ether, SATA, USB3 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
@@ -122,6 +129,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
 	UNIPHIER_PRO5_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
+	UNIPHIER_PRO4_SYS_CLK_ETHER(6),
 	UNIPHIER_LD4_SYS_CLK_STDMAC(8),				/* HSC, RLE */
 	/* GIO is always clock-enabled: no function for 0x2104 bit6 */
 	UNIPHIER_PRO4_SYS_CLK_USB3(14, 0),
@@ -142,6 +150,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
+	UNIPHIER_LD11_SYS_CLK_ETHER(6),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
 	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
 	/* CPU gears */
@@ -171,6 +180,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_LD11_SYS_CLK_EMMC(4),
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD20_SYS_CLK_SD,
+	UNIPHIER_LD11_SYS_CLK_ETHER(6),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC */
 	/* GIO is always clock-enabled: no function for 0x210c bit5 */
 	/*
-- 
2.7.4
