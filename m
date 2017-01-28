From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 28 Jan 2017 22:27:00 +0900
Subject: [PATCH 1/2] clk: uniphier: add NAND clock for all UniPhier SoCs
Message-ID: <1485610021-9905-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock line for the Denali NAND controller.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index d049316..b1aaf77 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -29,6 +29,12 @@
 	UNIPHIER_CLK_FACTOR("sd-200m", -1, "spll", 1, 10),		\
 	UNIPHIER_CLK_FACTOR("sd-133m", -1, "spll", 1, 15)
 
+#define UNIPHIER_SLD3_SYS_CLK_NAND(idx)					\
+	UNIPHIER_CLK_GATE("nand", (idx), NULL, 0x2104, 2)
+
+#define UNIPHIER_LD11_SYS_CLK_NAND(idx)					\
+	UNIPHIER_CLK_GATE("nand", (idx), NULL, 0x210c, 0)
+
 #define UNIPHIER_SLD3_SYS_CLK_STDMAC(idx)				\
 	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x2104, 10)
 
@@ -48,6 +54,7 @@ const struct uniphier_clk_data uniphier_sld3_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_SLD3_SYS_CLK_NAND(2),
 	UNIPHIER_SLD3_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),
@@ -61,6 +68,7 @@ const struct uniphier_clk_data uniphier_ld4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 5625, 512),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 16),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_SLD3_SYS_CLK_NAND(2),
 	UNIPHIER_SLD3_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* Ether, HSC, MIO */
@@ -74,6 +82,7 @@ const struct uniphier_clk_data uniphier_pro4_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "a2pll", 1, 8),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 32),
+	UNIPHIER_SLD3_SYS_CLK_NAND(2),
 	UNIPHIER_SLD3_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* HSC, MIO, RLE */
@@ -89,6 +98,7 @@ const struct uniphier_clk_data uniphier_sld8_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vpll27a", -1, "ref", 270, 25),	/* 270 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 20),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 16),
+	UNIPHIER_SLD3_SYS_CLK_NAND(2),
 	UNIPHIER_SLD3_SYS_CLK_SD,
 	UNIPHIER_CLK_FACTOR("usb2", -1, "upll", 1, 12),
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),		/* Ether, HSC, MIO */
@@ -101,6 +111,7 @@ const struct uniphier_clk_data uniphier_pro5_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("dapll2", -1, "ref", 144, 125),	/* 2949.12 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "dapll2", 1, 40),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_SLD3_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC */
 	UNIPHIER_PRO4_SYS_CLK_GIO(12),				/* PCIe, USB3 */
@@ -113,6 +124,7 @@ const struct uniphier_clk_data uniphier_pxs2_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("spll", -1, "ref", 96, 1),		/* 2400 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 27),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 48),
+	UNIPHIER_SLD3_SYS_CLK_NAND(2),
 	UNIPHIER_PRO5_SYS_CLK_SD,
 	UNIPHIER_SLD3_SYS_CLK_STDMAC(8),			/* HSC, RLE */
 	/* GIO is always clock-enabled: no function for 0x2104 bit6 */
@@ -131,6 +143,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vspll", -1, "ref", 80, 1),		/* 2000 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
 	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
 	/* CPU gears */
@@ -156,6 +169,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("vppll", -1, "ref", 504, 5),	/* 2520 MHz */
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
+	UNIPHIER_LD11_SYS_CLK_NAND(2),
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC */
 	/* GIO is always clock-enabled: no function for 0x210c bit5 */
-- 
2.7.4
