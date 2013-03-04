From: josephl@nvidia.com (Joseph Lo)
Date: Mon, 4 Mar 2013 19:41:10 +0800
Subject: [PATCH 07/10] ARM: dts: tegra: add power gpio keys to DT
Message-ID: <1362397270-5966-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the power gpio key to DT and enable the wakeup of the gpio key
for the device. The Seaboard and paz00 already had the power gpio key
binding and the power key of Whistler was on KBC. So these boards' device
tree didn't include in this patch.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 11 +++++++++++
 arch/arm/boot/dts/tegra20-trimslice.dts | 11 +++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts   | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index fd04882..06f4f68 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -574,6 +574,17 @@
 				0x1F0400D6>;	/* KEY_QUESTION */
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio 170 1>; /* gpio PV2, active low */
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index a905d2a..e210b24 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -344,6 +344,17 @@
 		gpios = <&gpio 191 1>; /* gpio PX7, active low */
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio 190 1>; /* gpio PX6, active low */
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 2fc1b81..c428cd0 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -537,6 +537,17 @@
 		bus-width = <8>;
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio 170 1>; /* gpio PV2, active low */
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
1.8.1.1
