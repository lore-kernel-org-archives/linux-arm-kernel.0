From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 13 Apr 2017 15:28:26 -0300
Subject: [PATCH v2 09/22] ARM: dts: lpc18xx: Add generic compatible string for
 I2C EEPROM
In-Reply-To: <20170413182839.25381-1-javier@osg.samsung.com>
References: <20170413182839.25381-1-javier@osg.samsung.com>
Message-ID: <20170413182839.25381-10-javier@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at24 driver allows to register I2C EEPROM chips using different vendor
and devices, but the I2C subsystem does not take the vendor into account
when matching using the I2C table since it only has device entries.

But when matching using an OF table, both the vendor and device has to be
taken into account so the driver defines only a set of compatible strings
using the "atmel" vendor as a generic fallback for compatible I2C devices.

So add this generic fallback to the device node compatible string to make
the device to match the driver using the OF device ID table.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
---

Changes in v2: None

 arch/arm/boot/dts/lpc4337-ciaa.dts          | 6 +++---
 arch/arm/boot/dts/lpc4350-hitex-eval.dts    | 2 +-
 arch/arm/boot/dts/lpc4357-ea4357-devkit.dts | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/lpc4337-ciaa.dts b/arch/arm/boot/dts/lpc4337-ciaa.dts
index 7c16d639a1b4..8b584b39db7d 100644
--- a/arch/arm/boot/dts/lpc4337-ciaa.dts
+++ b/arch/arm/boot/dts/lpc4337-ciaa.dts
@@ -174,17 +174,17 @@
 	clock-frequency = <400000>;
 
 	eeprom at 50 {
-		compatible = "microchip,24c512";
+		compatible = "microchip,24c512","atmel,24c512";
 		reg = <0x50>;
 	};
 
 	eeprom at 51 {
-		compatible = "microchip,24c02";
+		compatible = "microchip,24c02","atmel,24c02";
 		reg = <0x51>;
 	};
 
 	eeprom at 54 {
-		compatible = "microchip,24c512";
+		compatible = "microchip,24c512","atmel,24c512";
 		reg = <0x54>;
 	};
 };
diff --git a/arch/arm/boot/dts/lpc4350-hitex-eval.dts b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
index 874c75d44013..32a512926a8f 100644
--- a/arch/arm/boot/dts/lpc4350-hitex-eval.dts
+++ b/arch/arm/boot/dts/lpc4350-hitex-eval.dts
@@ -429,7 +429,7 @@
 	};
 
 	eeprom at 50 {
-		compatible = "nxp,24c02";
+		compatible = "nxp,24c02","atmel,24c02";
 		reg = <0x50>;
 	};
 
diff --git a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
index 9b5fad622522..7000a565f50b 100644
--- a/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
+++ b/arch/arm/boot/dts/lpc4357-ea4357-devkit.dts
@@ -490,7 +490,7 @@
 	};
 
 	eeprom at 57 {
-		compatible = "microchip,24c64";
+		compatible = "microchip,24c64","atmel,24c64";
 		reg = <0x57>;
 	};
 };
-- 
2.9.3
