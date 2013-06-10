From: rklein@nvidia.com (Rhyland Klein)
Date: Mon, 10 Jun 2013 17:26:42 -0400
Subject: [PATCH 4/4] arm: tegra: Add power-supplies link between battery and
 charger
In-Reply-To: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
References: <1370899602-22123-1-git-send-email-rklein@nvidia.com>
Message-ID: <1370899602-22123-5-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power supply core now supports detecting linkages between batteries
and chargers through the use of the power-supplies property. Adding
this to the battery, the core will use the phandle list to find
the associated charger and pair them up. This facilitates notifications
from the charger to the battery when ac power is dissconnected
or connected for instance.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index cfeb0f5..b92922f 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -727,6 +727,7 @@
 			battery-name = "battery";
 			sbs,i2c-retry-count = <2>;
 			sbs,poll-retry-count = <100>;
+			power-supplies = <&charger>;
 		};
 	};
 
@@ -763,7 +764,7 @@
 			vsys-l1-supply = <&vdd_ac_bat_reg>;
 			vsys-l2-supply = <&vdd_ac_bat_reg>;
 
-			charger {
+			charger: charger {
 				compatible = "ti,tps65090-charger";
 				ti,enable-low-current-chrg;
 			};
-- 
1.7.9.5
