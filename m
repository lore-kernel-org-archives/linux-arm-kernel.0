From: acourbot@nvidia.com (Alexandre Courbot)
Date: Wed, 1 Jul 2015 18:13:46 +0900
Subject: [PATCH 2/4] ARM: tegra: venice2: Add GK20A GPU DT node
In-Reply-To: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
References: <1435742028-8237-1-git-send-email-acourbot@nvidia.com>
Message-ID: <1435742028-8237-3-git-send-email-acourbot@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thierry Reding <treding@nvidia.com>

Add the device-tree node for the GK20A GPU and leave it disabled.
It is the responsability of the bootloader to enable it if the
VPR registers have been programmed such as the GPU can operate.

Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
 arch/arm/boot/dts/tegra124-venice2.dts | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra124-venice2.dts b/arch/arm/boot/dts/tegra124-venice2.dts
index 5c3f7813360d..497a50ebfe44 100644
--- a/arch/arm/boot/dts/tegra124-venice2.dts
+++ b/arch/arm/boot/dts/tegra124-venice2.dts
@@ -43,6 +43,14 @@
 		};
 	};
 
+	gpu at 0,57000000 {
+		/*
+		 * Node left disabled on purpose - the bootloader will enable
+		 * it after having set the VPR up
+		 */
+		vdd-supply = <&vdd_gpu>;
+	};
+
 	pinmux: pinmux at 0,70000868 {
 		pinctrl-names = "boot";
 		pinctrl-0 = <&pinmux_boot>;
@@ -735,7 +743,7 @@
 					regulator-always-on;
 				};
 
-				sd6 {
+				vdd_gpu: sd6 {
 					regulator-name = "+VDD_GPU_AP";
 					regulator-min-microvolt = <650000>;
 					regulator-max-microvolt = <1200000>;
-- 
2.4.4
