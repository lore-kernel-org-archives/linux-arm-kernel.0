From: denis@eukrea.com (Denis Carikli)
Date: Wed, 25 Jun 2014 14:41:35 +0200
Subject: [PATCH v3 2/3] ARM: dts: i.MX25: Fix gpt timers clocks.
In-Reply-To: <1403700096-13014-1-git-send-email-denis@eukrea.com>
References: <1403700096-13014-1-git-send-email-denis@eukrea.com>
Message-ID: <1403700096-13014-2-git-send-email-denis@eukrea.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without that fix, the board freeze during boot.

This appeared after the following commit:
  496f065 ARM: i.MX: Use of_clk_get_by_name() for timer clocks for DT case.

Signed-off-by: Denis Carikli <denis@eukrea.com>
Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
---
Changelog v2->v3:
- Splitted out the non-dts part.
- Added Sascha's ack which applied on the previous non-splitted patch.
- No code/dts changes.

Changelog v1->v2:
- Also fixed the ipg clock
- Also fixed the ipg and per clocks for the other gpts
---
 arch/arm/boot/dts/imx25.dtsi |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

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
-- 
1.7.9.5
