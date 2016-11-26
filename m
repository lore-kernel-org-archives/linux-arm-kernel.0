From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Sun, 27 Nov 2016 03:10:53 +0900
Subject: [PATCH] arm64: dts: uniphier: add SD-ctrl node for LD11 SoC
Message-ID: <1480183853-1231-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The LD11 SoC is equipped with SD-ctrl (0x59810000) as well as
MIO-ctrl (0x5b3e0000).  The SD-ctrl block on this SoC has just
one register for controlling RST_n pin of the eMMC device.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 0e5c58f..7a62fb9 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -273,6 +273,17 @@
 			reg = <0x59801000 0x400>;
 		};
 
+		sdctrl at 59810000 {
+			compatible = "socionext,uniphier-ld11-sdctrl",
+				     "simple-mfd", "syscon";
+			reg = <0x59810000 0x400>;
+
+			sd_rst: reset {
+				compatible = "socionext,uniphier-ld11-sd-reset";
+				#reset-cells = <1>;
+			};
+		};
+
 		perictrl at 59820000 {
 			compatible = "socionext,uniphier-perictrl",
 				     "simple-mfd", "syscon";
-- 
2.7.4
