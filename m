From: achew@nvidia.com (Andrew Chew)
Date: Mon, 1 Apr 2013 14:53:27 -0700
Subject: [PATCH V6 8/9] ARM: tegra: Provide regulator to pwm-backlight
In-Reply-To: <1364853208-32503-1-git-send-email-achew@nvidia.com>
References: <1364853208-32503-1-git-send-email-achew@nvidia.com>
Message-ID: <1364853208-32503-9-git-send-email-achew@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pwm-backlight driver now takes a mandatory regulator that is gotten
during driver probe.  Initialize a dummy regulator to satisfy this
requirement.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Alexandre Courbot <acourbot@nvidia.com>
Acked-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra20-medcom-wide.dts |  1 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi   | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/tegra20-medcom-wide.dts b/arch/arm/boot/dts/tegra20-medcom-wide.dts
index a2d6d65..90d665e 100644
--- a/arch/arm/boot/dts/tegra20-medcom-wide.dts
+++ b/arch/arm/boot/dts/tegra20-medcom-wide.dts
@@ -32,6 +32,7 @@
 
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
+		power-supply = <&backlight_power_reg>;
 	};
 
 	sound {
diff --git a/arch/arm/boot/dts/tegra20-tamonten.dtsi b/arch/arm/boot/dts/tegra20-tamonten.dtsi
index 6e9d91f..1ea3e42 100644
--- a/arch/arm/boot/dts/tegra20-tamonten.dtsi
+++ b/arch/arm/boot/dts/tegra20-tamonten.dtsi
@@ -485,5 +485,15 @@
 			regulator-max-microvolt = <5000000>;
 			regulator-always-on;
 		};
+
+		backlight_power_reg: regulator at 1 {
+			compatible = "regulator-fixed";
+			reg = <1>;
+			regulator-name = "lcd_bl_en";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio 13 0>; /* gpio PB5 */
+			enable-active-high;
+		};
 	};
 };
-- 
1.8.1.5
