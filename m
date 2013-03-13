From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 13 Mar 2013 16:01:19 +0800
Subject: [PATCH V3 5/9] ARM: dts: tegra: add power gpio keys to DT
In-Reply-To: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
References: <1363161683-20825-1-git-send-email-josephl@nvidia.com>
Message-ID: <1363161683-20825-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the power gpio key to DT and enable the wakeup of the gpio key
for the device. The Seaboard and paz00 already had the power gpio key
binding and the power key of Whistler was on KBC. So these boards' device
tree didn't include in this patch.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V3:
* no change
V2:
* no change
---
 arch/arm/boot/dts/tegra20-harmony.dts   | 11 +++++++++++
 arch/arm/boot/dts/tegra20-trimslice.dts | 11 +++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts   | 11 +++++++++++
 3 files changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-harmony.dts b/arch/arm/boot/dts/tegra20-harmony.dts
index 1f79c0d..3532853 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -568,6 +568,17 @@
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
index 98f3e44..3cfd9ed 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -335,6 +335,17 @@
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
index 4aef56f..ede91c0 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -531,6 +531,17 @@
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
1.8.1.5
