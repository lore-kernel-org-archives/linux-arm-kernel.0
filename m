From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Sat, 6 Jul 2013 14:44:29 +0530
Subject: [PATCH V2] ARM: tegra: enable gpio-keys on dalmore
Message-ID: <1373102069-5641-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dalmore have the keys mounted on board which are connected
to different pins of Tegra.

Add the keys entry in DTS file to enable key functionality.
This will enable KEY_POWER, KEY_HOME, KEY_VOLUMEUP and
KEY_VOLUMEDOWN.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
Changes from V1:
- Reorder the nodes.

 arch/arm/boot/dts/tegra114-dalmore.dts |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index cb640eb..259b517 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -883,6 +883,35 @@
 		};
 	};
 
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		home {
+			label = "Home";
+			gpios = <&gpio TEGRA_GPIO(I, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <102>; /* KEY_HOME */
+		};
+
+		power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+
+		volume_down {
+			label = "VolumeDown";
+			gpios = <&gpio TEGRA_GPIO(R, 1) GPIO_ACTIVE_LOW>;
+			linux,code = <114>; /* KEY_VOLUMEDOWN */
+		};
+
+		volume_up {
+			label = "VolumeUp";
+			gpios = <&gpio TEGRA_GPIO(R, 2) GPIO_ACTIVE_LOW>;
+			linux,code = <115>; /* KEY_VOLUMEUP */
+		};
+	};
+
 	regulators {
 		compatible = "simple-bus";
 		#address-cells = <1>;
@@ -976,4 +1005,5 @@
 			 <&tegra_car TEGRA114_CLK_EXTERN1>;
 		clock-names = "pll_a", "pll_a_out0", "mclk";
 	};
+
 };
-- 
1.7.1.1
