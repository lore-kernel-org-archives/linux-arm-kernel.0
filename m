From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 23 May 2017 15:34:42 +0200
Subject: [PATCH v5 14/20] arm64: dts: ls1043a: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170523133448.4794-1-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
Message-ID: <20170523133448.4794-15-javier@dowhile0.org>
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

Changes in v5: None
Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
index d64370ed0738..0a3853240c8b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-rdb.dts
@@ -75,11 +75,11 @@
 		reg = <0x4c>;
 	};
 	eeprom at 52 {
-		compatible = "at24,24c512";
+		compatible = "atmel,24c512";
 		reg = <0x52>;
 	};
 	eeprom at 53 {
-		compatible = "at24,24c512";
+		compatible = "atmel,24c512";
 		reg = <0x53>;
 	};
 	rtc at 68 {
-- 
2.9.3
