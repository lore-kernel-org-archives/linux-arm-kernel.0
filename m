From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 17 Oct 2016 00:42:42 +0900
Subject: [PATCH 1/2] arm64: dts: uniphier: increase register region size of
 sysctrl node
Message-ID: <1476632563-7446-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The System Control node has 0x10000 byte of registers.  The current
reg size must be expanded to use the cpufreq driver because the
registers controlling CPU frequency are located at offset 0x8000.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi | 2 +-
 arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 3eb4c42..da3cdd8 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -320,7 +320,7 @@
 		sysctrl at 61840000 {
 			compatible = "socionext,uniphier-ld11-sysctrl",
 				     "simple-mfd", "syscon";
-			reg = <0x61840000 0x4000>;
+			reg = <0x61840000 0x10000>;
 
 			sys_clk: clock {
 				compatible = "socionext,uniphier-ld11-clock";
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 08fd7cf..efb47ea 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -311,7 +311,7 @@
 		sysctrl at 61840000 {
 			compatible = "socionext,uniphier-sysctrl",
 				     "simple-mfd", "syscon";
-			reg = <0x61840000 0x4000>;
+			reg = <0x61840000 0x10000>;
 
 			sys_clk: clock {
 				compatible = "socionext,uniphier-ld20-clock";
-- 
1.9.1
