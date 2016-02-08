From: Suravee.Suthikulpanit@amd.com (Suravee Suthikulpanit)
Date: Mon, 8 Feb 2016 11:59:12 -0600
Subject: [PATCH V2 07/12] dtb: amd: Misc changes for GPIO devices
In-Reply-To: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
References: <1454954357-8395-1-git-send-email-Suravee.Suthikulpanit@amd.com>
Message-ID: <1454954357-8395-8-git-send-email-Suravee.Suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Add new GPIO device nodes and fix clock on gpio0.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi | 49 +++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
index 9f59381..ba455d1 100644
--- a/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
+++ b/arch/arm64/boot/dts/amd/amd-seattle-soc.dtsi
@@ -129,7 +129,7 @@
 			#size-cells = <0>;
 		};
 
-		gpio0: gpio at e1040000 {
+		gpio0: gpio at e1040000 { /* Not available to OS for B0 */
 			status = "disabled";
 			compatible = "arm,pl061", "arm,primecell";
 			#gpio-cells = <2>;
@@ -138,18 +138,59 @@
 			interrupts = <0 359 4>;
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			clocks = <&uartspiclk_100mhz>;
+			clocks = <&miscclk_250mhz>;
 			clock-names = "apb_pclk";
 		};
 
-		gpio1: gpio at e1050000 {
+		gpio1: gpio at e1050000 { /* [0:7] */
 			status = "disabled";
 			compatible = "arm,pl061", "arm,primecell";
 			#gpio-cells = <2>;
 			reg = <0 0xe1050000 0 0x1000>;
 			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
 			interrupts = <0 358 4>;
-			clocks = <&uartspiclk_100mhz>;
+			clocks = <&miscclk_250mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio2: gpio at e0020000 { /* [8:15] */
+			status = "disabled";
+			compatible = "arm,pl061", "arm,primecell";
+			#gpio-cells = <2>;
+			reg = <0 0xe0020000 0 0x1000>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 366 4>;
+			clocks = <&miscclk_250mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio3: gpio at e0030000 { /* [16:23] */
+			status = "disabled";
+			compatible = "arm,pl061", "arm,primecell";
+			#gpio-cells = <2>;
+			reg = <0 0xe0030000 0 0x1000>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 365 4>;
+			clocks = <&miscclk_250mhz>;
+			clock-names = "apb_pclk";
+		};
+
+		gpio4: gpio at e0080000 { /* [24] */
+			status = "disabled";
+			compatible = "arm,pl061", "arm,primecell";
+			#gpio-cells = <2>;
+			reg = <0 0xe0080000 0 0x1000>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <0 361 4>;
+			clocks = <&miscclk_250mhz>;
 			clock-names = "apb_pclk";
 		};
 
-- 
2.5.0
