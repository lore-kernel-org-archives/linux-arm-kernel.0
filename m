From: josephl@nvidia.com (Joseph Lo)
Date: Wed, 3 Apr 2013 19:31:48 +0800
Subject: [PATCH V6 5/9] ARM: dts: tegra: add power gpio keys to DT
In-Reply-To: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
References: <1364988712-24797-1-git-send-email-josephl@nvidia.com>
Message-ID: <1364988712-24797-6-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the power gpio key to DT and enable the wakeup of the gpio key
for the device. The Seaboard and paz00 already had the power gpio key
binding and the power key of Whistler was on KBC. So these boards' device
tree didn't include in this patch.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
V6:
* no change
V5:
* no change
V4:
* no change
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
index 2c4da87..d86dd85 100644
--- a/arch/arm/boot/dts/tegra20-harmony.dts
+++ b/arch/arm/boot/dts/tegra20-harmony.dts
@@ -464,6 +464,17 @@
 		};
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
 	kbc {
 		status = "okay";
 		nvidia,debounce-delay-ms = <2>;
diff --git a/arch/arm/boot/dts/tegra20-trimslice.dts b/arch/arm/boot/dts/tegra20-trimslice.dts
index 51b3a44..f96870c 100644
--- a/arch/arm/boot/dts/tegra20-trimslice.dts
+++ b/arch/arm/boot/dts/tegra20-trimslice.dts
@@ -343,6 +343,17 @@
 		};
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
 	poweroff {
 		compatible = "gpio-poweroff";
 		gpios = <&gpio 191 1>; /* gpio PX7, active low */
diff --git a/arch/arm/boot/dts/tegra20-ventana.dts b/arch/arm/boot/dts/tegra20-ventana.dts
index 7095e96..5688d9f 100644
--- a/arch/arm/boot/dts/tegra20-ventana.dts
+++ b/arch/arm/boot/dts/tegra20-ventana.dts
@@ -544,6 +544,17 @@
 		};
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
1.8.2
