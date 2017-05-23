From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Tue, 23 May 2017 15:34:39 +0200
Subject: [PATCH v5 11/20] ARM: dts: socfpga: Add generic compatible string for
 I2C EEPROM
In-Reply-To: <20170523133448.4794-1-javier@dowhile0.org>
References: <20170523133448.4794-1-javier@dowhile0.org>
Message-ID: <20170523133448.4794-12-javier@dowhile0.org>
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

 arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
index 893198049397..4bb2791ab04a 100644
--- a/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
+++ b/arch/arm/boot/dts/socfpga_cyclone5_vining_fpga.dts
@@ -294,7 +294,7 @@
 	clock-frequency = <100000>;
 
 	at24 at 50 {
-		compatible = "at24,24c02";
+		compatible = "atmel,24c02";
 		pagesize = <8>;
 		reg = <0x50>;
 	};
-- 
2.9.3
