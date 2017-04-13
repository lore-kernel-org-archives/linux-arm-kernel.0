From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 13 Apr 2017 15:28:32 -0300
Subject: [PATCH v2 15/22] arm64: dts: ls1043a: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170413182839.25381-1-javier@osg.samsung.com>
References: <20170413182839.25381-1-javier@osg.samsung.com>
Message-ID: <20170413182839.25381-16-javier@osg.samsung.com>
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

 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index c37110bc1506..d6551b95b662 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -75,11 +75,11 @@
 		reg = <0x4c>;
 	};
 	eeprom at 52 {
-		compatible = "at24,24c512";
+		compatible = "at24,24c512","atmel,24c512";
 		reg = <0x52>;
 	};
 	eeprom at 53 {
-		compatible = "at24,24c512";
+		compatible = "at24,24c512","atmel,24c512";
 		reg = <0x53>;
 	};
 	rtc at 68 {
-- 
2.9.3
