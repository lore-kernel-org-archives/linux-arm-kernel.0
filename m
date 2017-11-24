From: javierm@redhat.com (Javier Martinez Canillas)
Date: Fri, 24 Nov 2017 17:27:47 +0100
Subject: [RESEND PATCH 1/4] ARM: dts: efm32: Add generic compatible string for
 I2C EEPROM
Message-ID: <20171124162750.18756-1-javierm@redhat.com>
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

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
---

 arch/arm/boot/dts/efm32gg-dk3750.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index c9f3ea29cf9e..adfa559a488b 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -37,7 +37,7 @@
 			};
 
 			eeprom at 50 {
-				compatible = "microchip,24c02";
+				compatible = "microchip,24c02", "atmel,24c02";
 				reg = <0x50>;
 				pagesize = <16>;
 			};
-- 
2.14.3
