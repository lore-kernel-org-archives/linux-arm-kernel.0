From: mindentropy@gmail.com (mindentropy)
Date: Wed, 28 Jun 2017 23:15:18 +0530
Subject: [PATCH] Modified imx7d-sdb.dts file so that VLDO4 provides 2.8V for
 MIPI CSI/DSI
Message-ID: <20170628174518.5950-1-mindentropy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gautam Bhat <mindentropy@gmail.com>

 * According to mx7sabresd schematics the MIPI CSI/DSI voltage rails
   should be 2.8V but the voltage provided is a maximum of 3.3V and
   minimum of 1.8V. Providing such a higher voltage might damage the
   peripherals and violates the schematic settings.

Signed-off-by: Gautam Bhat <mindentropy@gmail.com>
---
 arch/arm/boot/dts/imx7d-sdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 5be01a1bf840..1da1f97ec342 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -262,8 +262,8 @@
 			};
 
 			vgen6_reg: vldo4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <3300000>;
+				regulator-min-microvolt = <2800000>;
+				regulator-max-microvolt = <2800000>;
 				regulator-always-on;
 			};
 		};
-- 
2.11.0
