From: nm@ti.com (Nishanth Menon)
Date: Mon, 22 Feb 2016 10:51:07 -0600
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Add eeprom information
In-Reply-To: <1456159868-32416-1-git-send-email-nm@ti.com>
References: <1456159868-32416-1-git-send-email-nm@ti.com>
Message-ID: <1456159868-32416-2-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add EEPROM at 0x50 that describes the board configuration.
This is useful for userspace programs that may need to check board
revision and other similar information.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 36c0fa6c362a..50312f80b972 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -591,6 +591,11 @@
 		DRVDD-supply = <&vdd_3v3>;
 		DVDD-supply = <&aic_dvdd>;
 	};
+
+	eeprom: eeprom at 50 {
+		compatible = "at,24c32";
+		reg = <0x50>;
+	};
 };
 
 &i2c3 {
-- 
2.7.0
