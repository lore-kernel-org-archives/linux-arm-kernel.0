From: rklein@nvidia.com (Rhyland Klein)
Date: Wed, 10 Apr 2013 15:51:45 -0400
Subject: [PATCH] ARM: tegra: Add charger subnode to tps65090 node
Message-ID: <1365623505-6309-1-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The charger is now represented by a distinct subnode of the tps65090
device. Add this node and enable low current charging with it.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
- This patch is dependent upon the following fixup-patch.
  http://patchwork.ozlabs.org/patch/235434/

 arch/arm/boot/dts/tegra114-dalmore.dts |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index 72c1f27..d257441 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -763,6 +763,11 @@
 			vsys-l1-supply = <&vdd_ac_bat_reg>;
 			vsys-l2-supply = <&vdd_ac_bat_reg>;
 
+			charger {
+				compatible = "ti,tps65090-charger";
+				ti,enable-low-current-chrg;
+			};
+
 			regulators {
 				tps65090_dcdc1_reg: dcdc1 {
 					regulator-name = "vdd-sys-5v0";
-- 
1.7.9.5
