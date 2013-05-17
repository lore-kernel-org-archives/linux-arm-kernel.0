From: b32955@freescale.com (Huang Shijie)
Date: Fri, 17 May 2013 17:15:23 +0800
Subject: [PATCH] ARM: imx6q: clk: add the eim_slow clock
Message-ID: <1368782123-15523-1-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the eim_slow clock, since the weim needs it.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 .../devicetree/bindings/clock/imx6q-clock.txt      |    1 +
 arch/arm/mach-imx/clk-imx6q.c                      |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.txt b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
index 6deb6fd..a0e104f 100644
--- a/Documentation/devicetree/bindings/clock/imx6q-clock.txt
+++ b/Documentation/devicetree/bindings/clock/imx6q-clock.txt
@@ -208,6 +208,7 @@ clocks and IDs.
 	pll4_post_div		193
 	pll5_post_div		194
 	pll5_video_div		195
+	eim_slow      		196
 
 Examples:
 
diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 50095dd..441a22d 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -238,7 +238,7 @@ enum mx6q_clks {
 	pll4_audio, pll5_video, pll8_mlb, pll7_usb_host, pll6_enet, ssi1_ipg,
 	ssi2_ipg, ssi3_ipg, rom, usbphy1, usbphy2, ldb_di0_div_3_5, ldb_di1_div_3_5,
 	sata_ref, sata_ref_100m, pcie_ref, pcie_ref_125m, enet_ref, usbphy1_gate,
-	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, clk_max
+	usbphy2_gate, pll4_post_div, pll5_post_div, pll5_video_div, eim_slow, clk_max
 };
 
 static struct clk *clk[clk_max];
@@ -535,6 +535,7 @@ int __init mx6q_clocks_init(void)
 	clk[usdhc2]       = imx_clk_gate2("usdhc2",        "usdhc2_podf",       base + 0x80, 4);
 	clk[usdhc3]       = imx_clk_gate2("usdhc3",        "usdhc3_podf",       base + 0x80, 6);
 	clk[usdhc4]       = imx_clk_gate2("usdhc4",        "usdhc4_podf",       base + 0x80, 8);
+	clk[eim_slow]     = imx_clk_gate2("eim_slow",      "emi_slow_podf",     base + 0x80, 10);
 	clk[vdo_axi]      = imx_clk_gate2("vdo_axi",       "vdo_axi_sel",       base + 0x80, 12);
 	clk[vpu_axi]      = imx_clk_gate2("vpu_axi",       "vpu_axi_podf",      base + 0x80, 14);
 	clk[cko1]         = imx_clk_gate("cko1",           "cko1_podf",         base + 0x60, 7);
-- 
1.7.1
