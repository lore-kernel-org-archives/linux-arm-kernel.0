From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 13 Apr 2017 22:04:40 -0300
Subject: [PATCH v3 16/21] arm64: zynqmp: Add generic compatible string for I2C
 EEPROM
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
Message-ID: <20170414010445.21727-17-javier@osg.samsung.com>
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

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
index ef1b9e573af0..9f29f99984f7 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-ep108.dts
@@ -55,7 +55,7 @@
 	status = "okay";
 	clock-frequency = <400000>;
 	eeprom at 54 {
-		compatible = "at,24c64";
+		compatible = "at,24c64", "atmel,24c64";
 		reg = <0x54>;
 	};
 };
@@ -64,7 +64,7 @@
 	status = "okay";
 	clock-frequency = <400000>;
 	eeprom at 55 {
-		compatible = "at,24c64";
+		compatible = "at,24c64", "atmel,24c64";
 		reg = <0x55>;
 	};
 };
-- 
2.9.3
