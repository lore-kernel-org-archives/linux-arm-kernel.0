From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Mon, 22 May 2017 16:01:53 +0200
Subject: [PATCH v4 05/20] ARM: dts: efm32: Add generic compatible string for
 I2C EEPROM
In-Reply-To: <20170522140208.24652-1-javier@dowhile0.org>
References: <20170522140208.24652-1-javier@dowhile0.org>
Message-ID: <20170522140208.24652-6-javier@dowhile0.org>
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

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>

---

Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/efm32gg-dk3750.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/efm32gg-dk3750.dts b/arch/arm/boot/dts/efm32gg-dk3750.dts
index 98fc667d22c7..df960b4ba312 100644
--- a/arch/arm/boot/dts/efm32gg-dk3750.dts
+++ b/arch/arm/boot/dts/efm32gg-dk3750.dts
@@ -36,7 +36,7 @@
 			};
 
 			eeprom at 50 {
-				compatible = "microchip,24c02";
+				compatible = "atmel,24c02";
 				reg = <0x50>;
 				pagesize = <16>;
 			};
-- 
2.9.3
