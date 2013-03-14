From: nm@ti.com (Nishanth Menon)
Date: Thu, 14 Mar 2013 15:58:10 -0500
Subject: [PATCH 3/8] ARM: dts: OMAP3: use twl4030 vdd1 regulator for CPU
In-Reply-To: <1363294695-658-1-git-send-email-nm@ti.com>
References: <1363294695-658-1-git-send-email-nm@ti.com>
Message-ID: <1363294695-658-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define VDD1 regulator in twl4030 DT and mark it as the supply for the
various OMAP3 platforms.

Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "Beno?t Cousson" <b-cousson@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Keerthy <j-keerthy@ti.com>
Cc: linux-omap at vger.kernel.org
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: cpufreq at vger.kernel.org
Cc: linux-pm at vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts |    6 ++++++
 arch/arm/boot/dts/omap3-beagle.dts    |    6 ++++++
 arch/arm/boot/dts/omap3-evm.dts       |    6 ++++++
 arch/arm/boot/dts/twl4030.dtsi        |    6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 3705a81..7152746 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -13,6 +13,12 @@
 	model = "TI OMAP3 BeagleBoard xM";
 	compatible = "ti,omap3-beagle-xm, ti,omap3-beagle", "ti,omap3";
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index f624dc8..8886617 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -13,6 +13,12 @@
 	model = "TI OMAP3 BeagleBoard";
 	compatible = "ti,omap3-beagle", "ti,omap3";
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
diff --git a/arch/arm/boot/dts/omap3-evm.dts b/arch/arm/boot/dts/omap3-evm.dts
index e8ba1c2..d36d19f 100644
--- a/arch/arm/boot/dts/omap3-evm.dts
+++ b/arch/arm/boot/dts/omap3-evm.dts
@@ -13,6 +13,12 @@
 	model = "TI OMAP3 EVM (OMAP3530, AM/DM37x)";
 	compatible = "ti,omap3-evm", "ti,omap3";
 
+	cpus {
+		cpu at 0 {
+			cpu0-supply = <&vcc>;
+		};
+	};
+
 	memory {
 		device_type = "memory";
 		reg = <0x80000000 0x10000000>; /* 256 MB */
diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
index ed0bc95..608f2e6 100644
--- a/arch/arm/boot/dts/twl4030.dtsi
+++ b/arch/arm/boot/dts/twl4030.dtsi
@@ -23,6 +23,12 @@
 		compatible = "ti,twl4030-wdt";
 	};
 
+	vcc: regulator-vdd1 {
+		compatible = "ti,twl4030-vdd1";
+		regulator-min-microvolt = <600000>;
+		regulator-max-microvolt = <1450000>;
+	};
+
 	vdac: regulator-vdac {
 		compatible = "ti,twl4030-vdac";
 		regulator-min-microvolt = <1800000>;
-- 
1.7.9.5
