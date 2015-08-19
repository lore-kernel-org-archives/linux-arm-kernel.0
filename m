From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Wed, 19 Aug 2015 14:49:26 +0900
Subject: [PATCH v2] ARM: dts: UniPhier: fix PPI interrupt CPU mask of timer
 nodes
Message-ID: <1439963366-4848-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This SoC is integrated with 4 Cortex-A9 cores.  The GIC bindings
document says that the bits[15:8] of the 3rd cell of the interrupts
property represents PPI interrupt CPU mask.  Because the timer
interrupts are wired to all of the 4 cores, bits[15:8] should be set
to 0xf.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

Changes in v2:
  - Fix git-description

 arch/arm/boot/dts/uniphier-proxstream2.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-proxstream2.dtsi b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
index ccf795a..4c7b246 100644
--- a/arch/arm/boot/dts/uniphier-proxstream2.dtsi
+++ b/arch/arm/boot/dts/uniphier-proxstream2.dtsi
@@ -249,14 +249,14 @@
 		timer at 60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-			interrupts = <1 11 0x304>;
+			interrupts = <1 11 0xf04>;
 			clocks = <&arm_timer_clk>;
 		};
 
 		timer at 60000600 {
 			compatible = "arm,cortex-a9-twd-timer";
 			reg = <0x60000600 0x20>;
-			interrupts = <1 13 0x304>;
+			interrupts = <1 13 0xf04>;
 			clocks = <&arm_timer_clk>;
 		};
 
-- 
1.9.1
