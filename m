From: mindentropy@gmail.com (mindentropy)
Date: Sat,  1 Jul 2017 13:09:11 +0530
Subject: [PATCH v2] ARM: dts: imx7d-sdb: Set VLDO4 outpt to 2.8V for MIPI
 CSI/DSI
In-Reply-To: <CAOMZO5A41QFoJsC2ST1kvpCOs3-unzHDrqXshHa=2ShWWCOyZg@mail.gmail.com>
References: <CAOMZO5A41QFoJsC2ST1kvpCOs3-unzHDrqXshHa=2ShWWCOyZg@mail.gmail.com>
Message-ID: <20170701073911.7338-1-mindentropy@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gautam Bhat <mindentropy@gmail.com>

 * According to mx7sabresd schematics the MIPI CSI/DSI voltage rails
   should be 2.8V but the voltage provided is a maximum of 3.3V and
   minimum of 1.8V. Providing such a higher voltage might damage the
   peripherals and violates the schematic settings.

Signed-off-by: Gautam Bhat <mindentropy@gmail.com>
---
Changes in v2:
 - Added subject line according to convention

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
