From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 29 Feb 2016 18:36:50 +0530
Subject: [PATCH 1/2] arm64: tegra: Add DT entry for keys used in Jetson-TX1
Message-ID: <1456751211-14341-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT entry for keys used in Jetson-TX p2371-2180. This has
three keys, POWER, VOLUME-UP and VOLUME-DOWN.

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
index 683b339..18147eb 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra210-p2371-2180.dts
@@ -2,8 +2,33 @@
 
 #include "tegra210-p2180.dtsi"
 #include "tegra210-p2597.dtsi"
+#include <dt-bindings/input/input.h>
 
 / {
 	model = "NVIDIA Jetson TX1 Developer Kit";
 	compatible = "nvidia,p2371-2180", "nvidia,tegra210";
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio TEGRA_GPIO(X, 5) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_POWER>;
+			gpio-key,wakeup;
+		};
+
+		volume_down {
+			label = "Volume Down";
+			gpios = <&gpio TEGRA_GPIO(Y, 0) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		volume_up {
+			label = "Volume Up";
+			gpios = <&gpio TEGRA_GPIO(X, 6) GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
 };
-- 
2.1.4
