From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 3 May 2012 15:42:07 +0530
Subject: [PATCH V2 5/5] SPEAr: Add plgpio node in device tree dtsi files
In-Reply-To: <cover.1336039716.git.viresh.kumar@st.com>
References: <cover.1336039716.git.viresh.kumar@st.com>
Message-ID: <1f6d244ea3fc7f204c19907d8cbf8dbe20f0d35d.1336039716.git.viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/boot/dts/spear1310-evb.dts |    4 ++++
 arch/arm/boot/dts/spear1310.dtsi    |   22 ++++++++++++++++++++++
 arch/arm/boot/dts/spear1340-evb.dts |    4 ++++
 arch/arm/boot/dts/spear1340.dtsi    |   21 +++++++++++++++++++++
 arch/arm/boot/dts/spear310-evb.dts  |    4 ++++
 arch/arm/boot/dts/spear310.dtsi     |   15 +++++++++++++++
 arch/arm/boot/dts/spear320-evb.dts  |    4 ++++
 arch/arm/boot/dts/spear320.dtsi     |   16 ++++++++++++++++
 8 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/spear1310-evb.dts b/arch/arm/boot/dts/spear1310-evb.dts
index 8a51303..c090833 100644
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
index 9e61da4..c63bba2 100644
--- a/arch/arm/boot/dts/spear1310.dtsi
+++ b/arch/arm/boot/dts/spear1310.dtsi
@@ -70,6 +70,12 @@
 			status = "disabled";
 		};
 
+		pinmux at e0700000 {
+			compatible = "st,spear1310-pinmux";
+			reg = <0xe0700000 0x1000>;
+			gpio-phandle = <&gpiopinctrl>;
+		};
+
 		spi1: spi at 5d400000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x5d400000 0x1000>;
@@ -179,6 +185,22 @@
 			thermal at e07008c4 {
 				st,thermal-flags = <0x7000>;
 			};
+
+			gpiopinctrl: gpio at d8400000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xd8400000 0x1000>;
+				interrupts = <0 132 0x4>;
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
index 60e0e12..0bf9d8f 100644
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
index a26fc47..e5d4e05 100644
--- a/arch/arm/boot/dts/spear1340.dtsi
+++ b/arch/arm/boot/dts/spear1340.dtsi
@@ -24,6 +24,12 @@
 			status = "disabled";
 		};
 
+		pinmux at e0700000 {
+			compatible = "st,spear1340-pinmux";
+			reg = <0xe0700000 0x1000>;
+			gpio-phandle = <&gpiopinctrl>;
+		};
+
 		spi1: spi at 5d400000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0x5d400000 0x1000>;
@@ -51,6 +57,21 @@
 			thermal at e07008c4 {
 				st,thermal-flags = <0x2a00>;
 			};
+
+			gpiopinctrl: gpio at e2800000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xe2800000 0x1000>;
+				interrupts = <0 139 0x4>;
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
diff --git a/arch/arm/boot/dts/spear310-evb.dts b/arch/arm/boot/dts/spear310-evb.dts
index a551ee0..12ac5ed 100644
--- a/arch/arm/boot/dts/spear310-evb.dts
+++ b/arch/arm/boot/dts/spear310-evb.dts
@@ -148,6 +148,10 @@
 			       status = "okay";
 			};
 
+			gpio at b4000000 {
+			       status = "okay";
+			};
+
 			i2c0: i2c at d0180000 {
 			       status = "okay";
 			};
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index e47081c..fddf84c 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -25,6 +25,7 @@
 		pinmux at b4000000 {
 			compatible = "st,spear310-pinmux";
 			reg = <0xb4000000 0x1000>;
+			gpio-phandle = <&gpiopinctrl>;
 		};
 
 		fsmc: flash at 44000000 {
@@ -75,6 +76,20 @@
 				reg = <0xb2200000 0x1000>;
 				status = "disabled";
 			};
+
+			gpiopinctrl: gpio at b4000000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xb4000000 0x1000>;
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
index 26366f4..a2115aa 100644
--- a/arch/arm/boot/dts/spear320-evb.dts
+++ b/arch/arm/boot/dts/spear320-evb.dts
@@ -166,6 +166,10 @@
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
index 5372ca3..9adac5b 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -24,6 +24,7 @@
 		pinmux at b3000000 {
 			compatible = "st,spear320-pinmux";
 			reg = <0xb3000000 0x1000>;
+			gpio-phandle = <&gpiopinctrl>;
 		};
 
 		clcd at 90000000 {
@@ -90,6 +91,21 @@
 				reg = <0xa4000000 0x1000>;
 				status = "disabled";
 			};
+
+			gpiopinctrl: gpio at b3000000 {
+				compatible = "st,spear-plgpio";
+				reg = <0xb3000000 0x1000>;
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
1.7.9
