From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sat, 28 Jan 2017 22:27:01 +0900
Subject: [PATCH 2/2] clk: uniphier: add eMMC clock for LD11 and LD20 SoCs
In-Reply-To: <1485610021-9905-1-git-send-email-yamada.masahiro@socionext.com>
References: <1485610021-9905-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1485610021-9905-2-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock for the Cadence eMMC controller on LD11/LD20.
For the other SoCs, the clock for the eMMC controller is included
in the MIO/SD control block.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/clk/uniphier/clk-uniphier-sys.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index b1aaf77..c8027d9 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -35,6 +35,9 @@
 #define UNIPHIER_LD11_SYS_CLK_NAND(idx)					\
 	UNIPHIER_CLK_GATE("nand", (idx), NULL, 0x210c, 0)
 
+#define UNIPHIER_LD11_SYS_CLK_EMMC(idx)					\
+	UNIPHIER_CLK_GATE("emmc", (idx), NULL, 0x210c, 2)
+
 #define UNIPHIER_SLD3_SYS_CLK_STDMAC(idx)				\
 	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x2104, 10)
 
@@ -144,6 +147,8 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_LD11_SYS_CLK_EMMC(4),
+	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
 	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
 	/* CPU gears */
@@ -170,6 +175,8 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_CLK_FACTOR("uart", 0, "spll", 1, 34),
 	UNIPHIER_CLK_FACTOR("i2c", 1, "spll", 1, 40),
 	UNIPHIER_LD11_SYS_CLK_NAND(2),
+	UNIPHIER_LD11_SYS_CLK_EMMC(4),
+	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC */
 	/* GIO is always clock-enabled: no function for 0x210c bit5 */
-- 
2.7.4
