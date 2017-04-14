From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 13 Apr 2017 22:04:38 -0300
Subject: [PATCH v3 14/21] ARM: dts: zynq: Add generic compatible string for
 I2C EEPROM
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
Message-ID: <20170414010445.21727-15-javier@osg.samsung.com>
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

 arch/arm/boot/dts/zynq-zc702.dts | 2 +-
 arch/arm/boot/dts/zynq-zc706.dts | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 0cdad2cc8b78..9aae7e061d19 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -136,7 +136,7 @@
 			#size-cells = <0>;
 			reg = <2>;
 			eeprom at 54 {
-				compatible = "at,24c08";
+				compatible = "at,24c08", "atmel,24c08";
 				reg = <0x54>;
 			};
 		};
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index ad4bb06dba25..ff0fca1c41c8 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -92,7 +92,7 @@
 			#size-cells = <0>;
 			reg = <2>;
 			eeprom at 54 {
-				compatible = "at,24c08";
+				compatible = "at,24c08", "atmel,24c08";
 				reg = <0x54>;
 			};
 		};
-- 
2.9.3
