From: swarren@nvidia.com (Stephen Warren)
Date: Sat, 17 Dec 2011 22:18:23 -0700
Subject: [PATCH] arm/tegra: Seaboard: Add GPIO key device tree nodes
Message-ID: <1324185503-23413-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This brings all the GPIO key definitions from board-seaboard.c into
tegra-seaboard.dtsi.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra-seaboard.dts |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index f552bcc..3cfbd04 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -68,4 +68,24 @@
 	usb at c5000000 {
 		nvidia,vbus-gpio = <&gpio 24 0>; /* PD0 */
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		power {
+			label = "Power";
+			gpios = <&gpio 170 1>; /* gpio PV2, active low */
+			linux,code = <116>; /* KEY_POWER */
+			gpio-key,wakeup;
+		};
+
+		lid {
+			label = "Lid";
+			gpios = <&gpio 23 0>; /* gpio PC7 */
+			linux,input-type = <5>; /* EV_SW */
+			linux,code = <0>; /* SW_LID */
+			debounce-interval = <1>;
+			gpio-key,wakeup;
+		};
+	};
 };
-- 
1.7.5.4
