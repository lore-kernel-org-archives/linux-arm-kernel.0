From: denis@eukrea.com (Denis Carikli)
Date: Mon, 23 Jun 2014 15:25:26 +0200
Subject: [PATCH v2 1/2] ARM: dts: i.MX25: Fix gpt timers clocks.
Message-ID: <1403529927-13868-1-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that fix, the board freeze during boot.

This appeared after the following commit:
  496f065 ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.

Signed-off-by: Denis Carikli <denis@eukrea.com>
---
Changelog v1->v2:
- Also fixed the ipg clock
- Also fixed the ipg and per clocks for the other gpts
- Also fixed the ipg clock for non-dt init.
---
 arch/arm/boot/dts/imx25.dtsi  |    8 ++++----
 arch/arm/mach-imx/clk-imx25.c |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index bb74d95..c174039 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -312,7 +312,7 @@
 			gpt4: timer at 53f84000 {
 				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
 				reg = <0x53f84000 0x4000>;
-				clocks = <&clks 9>, <&clks 45>;
+				clocks = <&clks 95>, <&clks 47>;
 				clock-names = "ipg", "per";
 				interrupts = <1>;
 			};
@@ -320,7 +320,7 @@
 			gpt3: timer at 53f88000 {
 				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
 				reg = <0x53f88000 0x4000>;
-				clocks = <&clks 9>, <&clks 47>;
+				clocks = <&clks 94>, <&clks 47>;
 				clock-names = "ipg", "per";
 				interrupts = <29>;
 			};
@@ -328,7 +328,7 @@
 			gpt2: timer at 53f8c000 {
 				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
 				reg = <0x53f8c000 0x4000>;
-				clocks = <&clks 9>, <&clks 47>;
+				clocks = <&clks 93>, <&clks 47>;
 				clock-names = "ipg", "per";
 				interrupts = <53>;
 			};
@@ -336,7 +336,7 @@
 			gpt1: timer at 53f90000 {
 				compatible = "fsl,imx25-gpt", "fsl,imx31-gpt";
 				reg = <0x53f90000 0x4000>;
-				clocks = <&clks 9>, <&clks 47>;
+				clocks = <&clks 92>, <&clks 47>;
 				clock-names = "ipg", "per";
 				interrupts = <54>;
 			};
diff --git a/arch/arm/mach-imx/clk-imx25.c b/arch/arm/mach-imx/clk-imx25.c
index 887b508..e759a6d 100644
--- a/arch/arm/mach-imx/clk-imx25.c
+++ b/arch/arm/mach-imx/clk-imx25.c
@@ -242,7 +242,7 @@ int __init mx25_clocks_init(void)
 {
 	__mx25_clocks_init(24000000);
 
-	clk_register_clkdev(clk[ipg], "ipg", "imx-gpt.0");
+	clk_register_clkdev(clk[gpt1_ipg], "ipg", "imx-gpt.0");
 	clk_register_clkdev(clk[gpt_ipg_per], "per", "imx-gpt.0");
 	/* i.mx25 has the i.mx21 type uart */
 	clk_register_clkdev(clk[uart1_ipg], "ipg", "imx21-uart.0");
-- 
1.7.9.5
