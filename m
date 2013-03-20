From: rklein@nvidia.com (Rhyland Klein)
Date: Wed, 20 Mar 2013 11:31:32 -0400
Subject: [PATCH] ARM: tegra: Add sbs-battery node to Dalmore
Message-ID: <1363793492-2019-1-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the node for the bq20z45 I2C gas gauge which is
compatible with the sbs-battery power supply driver.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 arch/arm/boot/dts/tegra114-dalmore.dts |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts
index a61974e..6487188 100644
--- a/arch/arm/boot/dts/tegra114-dalmore.dts
+++ b/arch/arm/boot/dts/tegra114-dalmore.dts
@@ -718,6 +718,19 @@
 		clock-frequency = <408000000>;
 	};
 
+	i2c at 7000c000 {
+		status = "okay";
+		clock-frequency = <100000>;
+
+		battery: smart-battery at b {
+			compatible = "ti,bq20z45", "sbs,sbs-battery";
+			reg = <0xb>;
+			battery-name = "battery";
+			sbs,i2c-retry-count = <2>;
+			sbs,poll-retry-count = <100>;
+		};
+	};
+
 	pmc {
 		nvidia,invert-interrupt;
 	};
-- 
1.7.9.5
