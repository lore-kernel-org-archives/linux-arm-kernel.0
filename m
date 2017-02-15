From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 15 Feb 2017 20:42:52 +0530
Subject: [PATCH] ARM: dts: am57xx-idk: tpic2810 is on I2C bus, not SPI
Message-ID: <f884c250c4142ef44ec0c770aab277803f1f5da3.1487171304.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial
output support") added the TPIC2810 device-tree node under
SPI bus instead of I2C1.

Fix it. Tested on AM572x IDK by driving on-board LEDs
connected to TPIC2810

Fixes: 50e95b6b854c ("ARM: dts: am57xx-idk: Add Industrial output support")
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am57xx-idk-common.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-idk-common.dtsi b/arch/arm/boot/dts/am57xx-idk-common.dtsi
index 814a720d5c3d..d0a55b845690 100644
--- a/arch/arm/boot/dts/am57xx-idk-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-idk-common.dtsi
@@ -311,6 +311,13 @@
 			/* ID & VBUS GPIOs provided in board dts */
 		};
 	};
+
+	tpic2810: tpic2810 at 60 {
+		compatible = "ti,tpic2810";
+		reg = <0x60>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
 };
 
 &mcspi3 {
@@ -326,13 +333,6 @@
 		spi-max-frequency = <1000000>;
 		spi-cpol;
 	};
-
-	tpic2810: tpic2810 at 60 {
-		compatible = "ti,tpic2810";
-		reg = <0x60>;
-		gpio-controller;
-		#gpio-cells = <2>;
-	};
 };
 
 &uart3 {
-- 
2.9.0
