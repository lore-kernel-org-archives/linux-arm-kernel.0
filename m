From: marek@goldelico.com (Marek Belisko)
Date: Sat,  4 Jun 2016 14:05:55 +0200
Subject: [PATCH] ARM: dts: omap3-gta04: Add RFID eeprom node
Message-ID: <1465041955-410-1-git-send-email-marek@goldelico.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "H. Nikolaus Schaller" <hns@goldelico.com>

Define RFID eeprom node which is present on gta04
device.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
Signed-off-by: Marek Belisko <marek@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index a922472..b652dae 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -433,6 +433,12 @@
 		gpios = <&gpio6 0 GPIO_ACTIVE_LOW>;
 		ti,x-plate-ohms = <600>;
 	};
+
+	/* RFID EEPROM */
+	m24lr64 at 50 {
+		compatible = "at,24c64";
+		reg = <0x50>;
+	};
 };
 
 &i2c3 {
-- 
2.5.0
