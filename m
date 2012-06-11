From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 11 Jun 2012 12:28:12 -0600
Subject: [PATCH] ARM: dt: tegra seaboard: move battery monitor to mux'd I2C
 bus.
Message-ID: <1339439292-12958-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This depends on the previous posted
http://www.spinics.net/lists/linux-tegra/msg05043.html
which actually creates the I2C mux.

 arch/arm/boot/dts/tegra-seaboard.dts |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/tegra-seaboard.dts b/arch/arm/boot/dts/tegra-seaboard.dts
index 1e1939f..85e621a 100644
--- a/arch/arm/boot/dts/tegra-seaboard.dts
+++ b/arch/arm/boot/dts/tegra-seaboard.dts
@@ -331,13 +331,6 @@
 	i2c at 7000c400 {
 		status = "okay";
 		clock-frequency = <100000>;
-
-		smart-battery at b {
-			compatible = "ti,bq20z75", "smart-battery-1.1";
-			reg = <0xb>;
-			ti,i2c-retry-count = <2>;
-			ti,poll-retry-count = <10>;
-		};
 	};
 
 	i2cmux {
@@ -362,6 +355,13 @@
 			reg = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
+
+			smart-battery at b {
+				compatible = "ti,bq20z75", "smart-battery-1.1";
+				reg = <0xb>;
+				ti,i2c-retry-count = <2>;
+				ti,poll-retry-count = <10>;
+			};
 		};
 	};
 
-- 
1.7.0.4
