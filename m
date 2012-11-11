From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Sun, 11 Nov 2012 10:09:35 +0530
Subject: [PATCH 13/14] ARM: SPEAr3xx: DT: add shirq node for interrupt
 multiplexor
In-Reply-To: <cover.1352608333.git.viresh.kumar@linaro.org>
References: <cover.1352608333.git.viresh.kumar@linaro.org>
Message-ID: <3d37e6b451b075c1e1b4d139243c189ba800b03b.1352608333.git.viresh.kumar@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shiraz Hashim <shiraz.hashim@st.com>

shirq layer has been adapted to DT, add corresponding nodes in all
SPEAr3xx variants.

Signed-off-by: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/boot/dts/spear300.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/spear310.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/spear320.dtsi | 24 ++++++++++++++++++++++--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/spear300.dtsi b/arch/arm/boot/dts/spear300.dtsi
index fdac871..090adc6 100644
--- a/arch/arm/boot/dts/spear300.dtsi
+++ b/arch/arm/boot/dts/spear300.dtsi
@@ -52,6 +52,14 @@
 			status = "disabled";
 		};
 
+		shirq: interrupt-controller at 0x50000000 {
+			compatible = "st,spear300-shirq";
+			reg = <0x50000000 0x1000>;
+			interrupts = <28>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -64,12 +72,16 @@
 				compatible = "arm,pl061", "arm,primecell";
 				gpio-controller;
 				reg = <0xa9000000 0x1000>;
+				interrupts = <8>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			kbd at a0000000 {
 				compatible = "st,spear300-kbd";
 				reg = <0xa0000000 0x1000>;
+				interrupts = <7>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/spear310.dtsi b/arch/arm/boot/dts/spear310.dtsi
index 62fc4fb..0527e3a 100644
--- a/arch/arm/boot/dts/spear310.dtsi
+++ b/arch/arm/boot/dts/spear310.dtsi
@@ -39,6 +39,14 @@
 			status = "disabled";
 		};
 
+		shirq: interrupt-controller at 0xb4000000 {
+			compatible = "st,spear310-shirq";
+			reg = <0xb4000000 0x1000>;
+			interrupts = <28 29 30 1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
 		apb {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -49,30 +57,40 @@
 			serial at b2000000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xb2000000 0x1000>;
+				interrupts = <8>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			serial at b2080000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xb2080000 0x1000>;
+				interrupts = <9>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			serial at b2100000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xb2100000 0x1000>;
+				interrupts = <10>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			serial at b2180000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xb2180000 0x1000>;
+				interrupts = <11>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			serial at b2200000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xb2200000 0x1000>;
+				interrupts = <12>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 		};
diff --git a/arch/arm/boot/dts/spear320.dtsi b/arch/arm/boot/dts/spear320.dtsi
index 582ded7..52b9c05 100644
--- a/arch/arm/boot/dts/spear320.dtsi
+++ b/arch/arm/boot/dts/spear320.dtsi
@@ -29,7 +29,8 @@
 		clcd at 90000000 {
 			compatible = "arm,pl110", "arm,primecell";
 			reg = <0x90000000 0x1000>;
-			interrupts = <33>;
+			interrupts = <8>;
+			interrupt-parent = <&shirq>;
 			status = "disabled";
 		};
 
@@ -48,13 +49,24 @@
 		sdhci at 70000000 {
 			compatible = "st,sdhci-spear";
 			reg = <0x70000000 0x100>;
-			interrupts = <29>;
+			interrupts = <10>;
+			interrupt-parent = <&shirq>;
 			status = "disabled";
 		};
 
+		shirq: interrupt-controller at 0xb3000000 {
+			compatible = "st,spear320-shirq";
+			reg = <0xb3000000 0x1000>;
+			interrupts = <30 28 29 1>;
+			#interrupt-cells = <1>;
+			interrupt-controller;
+		};
+
 		spi1: spi at a5000000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0xa5000000 0x1000>;
+			interrupts = <15>;
+			interrupt-parent = <&shirq>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -63,6 +75,8 @@
 		spi2: spi at a6000000 {
 			compatible = "arm,pl022", "arm,primecell";
 			reg = <0xa6000000 0x1000>;
+			interrupts = <16>;
+			interrupt-parent = <&shirq>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -87,18 +101,24 @@
 				#size-cells = <0>;
 				compatible = "snps,designware-i2c";
 				reg = <0xa7000000 0x1000>;
+				interrupts = <21>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			serial at a3000000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xa3000000 0x1000>;
+				interrupts = <13>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 
 			serial at a4000000 {
 				compatible = "arm,pl011", "arm,primecell";
 				reg = <0xa4000000 0x1000>;
+				interrupts = <14>;
+				interrupt-parent = <&shirq>;
 				status = "disabled";
 			};
 		};
-- 
1.7.12.rc2.18.g61b472e
