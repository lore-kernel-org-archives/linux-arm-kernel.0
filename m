From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sat, 27 Oct 2012 15:21:39 +0530
Subject: [PATCH V2 5/5] ARM: SPEAr: Add plgpio node in device tree dtsi files
In-Reply-To: <cover.1351330569.git.viresh.kumar@linaro.org>
References: <cover.1351330569.git.viresh.kumar@linaro.org>
Message-ID: <32141e19f71afa93cf743cffaab4c4794ee4b008.1351330569.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds plgpio nodes in SPEAr DT files.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear1310-evb.dts |  4 ++++
 arch/arm/boot/dts/spear1310.dtsi    | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/spear1340-evb.dts |  4 ++++
 arch/arm/boot/dts/spear1340.dtsi    | 26 ++++++++++++++++++++++++++
 arch/arm/boot/dts/spear310.dtsi     | 22 +++++++++++++++++++++-
 arch/arm/boot/dts/spear320-evb.dts  |  4 ++++
 arch/arm/boot/dts/spear320.dtsi     | 23 ++++++++++++++++++++++-
 7 files changed, 108 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index dd4358b..2e4c572 100644
--- a/arch/arm/boot/dts/spear1310-evb.dts
+++ b/arch/arm/boot/dts/spear1310-evb.dts
@@ -181,6 +181,10 @@
 			       status = "okay";
 			};
 
+			gpio at d8400000 {
+			       status = "okay";
+			};
+
 			i2c0: i2c at e0280000 {
 			       status = "okay";
 			};
diff --git a/arch/arm/boot/dts/spear1310.dtsi b/arch/arm/boot/dts/spear1310.dtsi
index 419ea74..7cd25eb 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -70,6 +70,12 @@
 			status = "disabled";
 		};
 
+		pinmux: pinmux at e0700000 {
+			compatible = "st,spear1310-pinmux";
+			reg = <0xe0700000 0x1000>;
+			#gpio-range-cells = <2>;
+		};
+
 		spi1: spi at 5d400000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x5d400000 0x1000>;
@@ -179,6 +185,27 @@
 			thermal at e07008c4 {
 				st,thermal-flags = <0x7000>;
 			};
+
+			gpiopinctrl: gpio at d8400000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xd8400000 0x1000>;
+				interrupts = <0 100 0x4>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinmux 0 246>;
+				status = "disabled";
+
+				st-plgpio,ngpio = <246>;
+				st-plgpio,enb-reg = <0xd0>;
+				st-plgpio,wdata-reg = <0x90>;
+				st-plgpio,dir-reg = <0xb0>;
+				st-plgpio,ie-reg = <0x30>;
+				st-plgpio,rdata-reg = <0x70>;
+				st-plgpio,mis-reg = <0x10>;
+				st-plgpio,eit-reg = <0x50>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/spear1340-evb.dts b/arch/arm/boot/dts/spear1340-evb.dts
index c9a54e0..045f712 100644
--- a/arch/arm/boot/dts/spear1340-evb.dts
+++ b/arch/arm/boot/dts/spear1340-evb.dts
@@ -193,6 +193,10 @@
 			       status = "okay";
 			};
 
+			gpio at e2800000 {
+			       status = "okay";
+			};
+
 			i2c0: i2c at e0280000 {
 			       status = "okay";
 			};
diff --git a/arch/arm/boot/dts/spear1340.dtsi b/arch/arm/boot/dts/spear1340.dtsi
index d71fe2a..6c09eb0 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -24,6 +24,12 @@
 			status = "disabled";
 		};
 
+		pinmux: pinmux at e0700000 {
+			compatible = "st,spear1340-pinmux";
+			reg = <0xe0700000 0x1000>;
+			#gpio-range-cells = <2>;
+		};
+
 		spi1: spi at 5d400000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x5d400000 0x1000>;
@@ -51,6 +57,26 @@
 			thermal at e07008c4 {
 				st,thermal-flags = <0x2a00>;
 			};
+
+			gpiopinctrl: gpio at e2800000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xe2800000 0x1000>;
+				interrupts = <0 107 0x4>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinmux 0 252>;
+				status = "disabled";
+
+				st-plgpio,ngpio = <250>;
+				st-plgpio,wdata-reg = <0x40>;
+				st-plgpio,dir-reg = <0x00>;
+				st-plgpio,ie-reg = <0x80>;
+				st-plgpio,rdata-reg = <0x20>;
+				st-plgpio,mis-reg = <0xa0>;
+				st-plgpio,eit-reg = <0x60>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 62fc4fb..930303e 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -22,9 +22,10 @@
 			  0xb0000000 0xb0000000 0x10000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
-		pinmux at b4000000 {
+		pinmux: pinmux at b4000000 {
 			compatible = "st,spear310-pinmux";
 			reg = <0xb4000000 0x1000>;
+			#gpio-range-cells = <2>;
 		};
 
 		fsmc: flash at 44000000 {
@@ -75,6 +76,25 @@
 				reg = <0xb2200000 0x1000>;
 				status = "disabled";
 			};
+
+			gpiopinctrl: gpio at b4000000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xb4000000 0x1000>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinmux 0 102>;
+				status = "disabled";
+
+				st-plgpio,ngpio = <102>;
+				st-plgpio,enb-reg = <0x10>;
+				st-plgpio,wdata-reg = <0x20>;
+				st-plgpio,dir-reg = <0x30>;
+				st-plgpio,ie-reg = <0x50>;
+				st-plgpio,rdata-reg = <0x40>;
+				st-plgpio,mis-reg = <0x60>;
+			};
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/spear320-evb.dts b/arch/arm/boot/dts/spear320-evb.dts
index 082328b..ad4bfc6 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -164,6 +164,10 @@
 			       status = "okay";
 			};
 
+			gpio at b3000000 {
+			       status = "okay";
+			};
+
 			i2c0: i2c at d0180000 {
 			       status = "okay";
 			};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 1f49d69..67d7ada 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -21,9 +21,10 @@
 		ranges = <0x40000000 0x40000000 0x80000000
 			  0xd0000000 0xd0000000 0x30000000>;
 
-		pinmux at b3000000 {
+		pinmux: pinmux at b3000000 {
 			compatible = "st,spear320-pinmux";
 			reg = <0xb3000000 0x1000>;
+			#gpio-range-cells = <2>;
 		};
 
 		clcd at 90000000 {
@@ -90,6 +91,26 @@
 				reg = <0xa4000000 0x1000>;
 				status = "disabled";
 			};
+
+			gpiopinctrl: gpio at b3000000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xb3000000 0x1000>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinmux 0 102>;
+				status = "disabled";
+
+				st-plgpio,ngpio = <102>;
+				st-plgpio,enb-reg = <0x24>;
+				st-plgpio,wdata-reg = <0x34>;
+				st-plgpio,dir-reg = <0x44>;
+				st-plgpio,ie-reg = <0x64>;
+				st-plgpio,rdata-reg = <0x54>;
+				st-plgpio,mis-reg = <0x84>;
+				st-plgpio,eit-reg = <0x94>;
+			};
 		};
 	};
 };
-- 
1.7.12.rc2.18.g61b472e
