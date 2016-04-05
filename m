From: stefan@agner.ch (Stefan Agner)
Date: Mon,  4 Apr 2016 22:28:39 -0700
Subject: [PATCH v3 7/9] ARM: dts: vf610: add display nodes
In-Reply-To: <1459834121-25997-1-git-send-email-stefan@agner.ch>
References: <1459834121-25997-1-git-send-email-stefan@agner.ch>
Message-ID: <1459834121-25997-8-git-send-email-stefan@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the dcu and tcon nodes to enable the Display Controller Unit
and Timing Controller in Vybrid's SoC level device-tree file.

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/boot/dts/vfxxx.dtsi | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index a9ceb5b..78e24c6 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -234,6 +234,14 @@
 							<20000000>;
 			};
 
+			tcon0: timing-controller at 4003d000 {
+				compatible = "fsl,vf610-tcon";
+				reg = <0x4003d000 0x1000>;
+				clocks = <&clks VF610_CLK_TCON0>;
+				clock-names = "ipg";
+				status = "disabled";
+			};
+
 			wdoga5: wdog at 4003e000 {
 				compatible = "fsl,vf610-wdt", "fsl,imx21-wdt";
 				reg = <0x4003e000 0x1000>;
@@ -339,6 +347,17 @@
 				status = "disabled";
 			};
 
+			dcu0: dcu at 40058000 {
+				compatible = "fsl,vf610-dcu";
+				reg = <0x40058000 0x1200>;
+				interrupts = <30 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clks VF610_CLK_DCU0>,
+					<&clks VF610_CLK_DCU0_DIV>;
+				clock-names = "dcu", "pix";
+				fsl,tcon = <&tcon0>;
+				status = "disabled";
+			};
+
 			i2c0: i2c at 40066000 {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.7.4
