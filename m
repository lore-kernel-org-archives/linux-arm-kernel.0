From: rnayak@ti.com (Rajendra Nayak)
Date: Thu, 23 Feb 2012 17:05:54 +0530
Subject: [PATCH v3 2/2] arm/dts: twl: Pass regulator data from dt
In-Reply-To: <1329996954-27083-1-git-send-email-rnayak@ti.com>
References: <1329996954-27083-1-git-send-email-rnayak@ti.com>
Message-ID: <1329996954-27083-3-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pass all the voltage regulator information for
twl6030/twl4030 PMIC from device tree.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Benoit Cousson <b-cousson@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |    6 +++
 arch/arm/boot/dts/twl4030.dtsi     |   18 +++++++++++
 arch/arm/boot/dts/twl6030.dtsi     |   60 ++++++++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index 714ba5d..54556b1 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -26,6 +26,12 @@
 		reg = <0x48>;
 		interrupts = <7>; /* SYS_NIRQ cascaded to intc */
 		interrupt-parent = <&intc>;
+
+		vsim: regulator at 10 {
+			compatible = "ti,twl4030-vsim";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
 	};
 };
 
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index 8be5223..a94654c 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -18,4 +18,22 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	vdac: regulator at 0 {
+		compatible = "ti,twl4030-vdac";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vpll2: regulator at 1 {
+		compatible = "ti,twl4030-vpll2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
+	vmmc1: regulator at 2 {
+		compatible = "ti,twl4030-vmmc1";
+		regulator-min-microvolt = <1850000>;
+		regulator-max-microvolt = <3150000>;
+	};
 };
diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index b7b4e5e..efa19e8 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -19,4 +19,64 @@
 		compatible = "ti,twl4030-rtc";
 		interrupts = <11>;
 	};
+
+	vaux1: regulator at 0 {
+		compatible = "ti,twl6030-vaux1";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vaux2: regulator at 1 {
+		compatible = "ti,twl6030-vaux2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <2800000>;
+	};
+
+	vaux3: regulator at 2 {
+		compatible = "ti,twl6030-vaux3";
+		regulator-min-microvolt = <1000000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vmmc: regulator at 3 {
+		compatible = "ti,twl6030-vmmc";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <3000000>;
+	};
+
+	vpp: regulator at 4 {
+		compatible = "ti,twl6030-vpp";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <2500000>;
+	};
+
+	vusim: regulator at 5 {
+		compatible = "ti,twl6030-vusim";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <2900000>;
+	};
+
+	vdac: regulator at 6 {
+		compatible = "ti,twl6030-vdac";
+	};
+
+	vana: regulator at 7 {
+		compatible = "ti,twl6030-vana";
+	};
+
+	vcxio: regulator at 8 {
+		compatible = "ti,twl6030-vcxio";
+	};
+
+	vusb: regulator at 9 {
+		compatible = "ti,twl6030-vusb";
+	};
+
+	vusb: regulator at 9 {
+		compatible = "ti,twl6030-vusb";
+	};
+
+	clk32kg: regulator at 10 {
+		compatible = "ti,twl6030-clk32kg";
+	};
 };
-- 
1.7.1
