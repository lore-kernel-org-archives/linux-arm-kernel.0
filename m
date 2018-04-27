From: suzuki.katsuhiro@socionext.com (Katsuhiro Suzuki)
Date: Fri, 27 Apr 2018 09:40:13 +0900
Subject: [PATCH] clk: uniphier: add LD11/LD20 stream demux system clock
Message-ID: <20180427004013.4006-1-suzuki.katsuhiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add clock for MPEG2 transport stream I/O and demux system (HSC) on
UniPhier LD11/LD20 SoCs.

Signed-off-by: Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>
---
 drivers/clk/uniphier/clk-uniphier-sys.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/uniphier/clk-uniphier-sys.c b/drivers/clk/uniphier/clk-uniphier-sys.c
index ebc78ab2df05..4f5ff9fa11fd 100644
--- a/drivers/clk/uniphier/clk-uniphier-sys.c
+++ b/drivers/clk/uniphier/clk-uniphier-sys.c
@@ -51,6 +51,9 @@
 #define UNIPHIER_LD11_SYS_CLK_STDMAC(idx)				\
 	UNIPHIER_CLK_GATE("stdmac", (idx), NULL, 0x210c, 8)
 
+#define UNIPHIER_LD11_SYS_CLK_HSC(idx)					\
+	UNIPHIER_CLK_GATE("hsc", (idx), NULL, 0x210c, 9)
+
 #define UNIPHIER_PRO4_SYS_CLK_GIO(idx)					\
 	UNIPHIER_CLK_GATE("gio", (idx), NULL, 0x2104, 6)
 
@@ -182,6 +185,7 @@ const struct uniphier_clk_data uniphier_ld11_sys_clk_data[] = {
 	/* Index 5 reserved for eMMC PHY */
 	UNIPHIER_LD11_SYS_CLK_ETHER(6),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC, MIO */
+	UNIPHIER_LD11_SYS_CLK_HSC(9),
 	UNIPHIER_CLK_FACTOR("usb2", -1, "ref", 24, 25),
 	UNIPHIER_LD11_SYS_CLK_AIO(40),
 	UNIPHIER_LD11_SYS_CLK_EVEA(41),
@@ -215,6 +219,7 @@ const struct uniphier_clk_data uniphier_ld20_sys_clk_data[] = {
 	UNIPHIER_LD20_SYS_CLK_SD,
 	UNIPHIER_LD11_SYS_CLK_ETHER(6),
 	UNIPHIER_LD11_SYS_CLK_STDMAC(8),			/* HSC */
+	UNIPHIER_LD11_SYS_CLK_HSC(9),
 	/* GIO is always clock-enabled: no function for 0x210c bit5 */
 	/*
 	 * clock for USB Link is enabled by the logic "OR" of bit 14 and bit 15.
-- 
2.17.0
