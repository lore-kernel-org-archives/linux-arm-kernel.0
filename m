From: javier@dowhile0.org (Javier Martinez Canillas)
Date: Thu, 15 Jun 2017 20:54:09 +0200
Subject: [RESEND PATCH v5 07/16] ARM: dts: koelsch: Add generic compatible
 string for I2C EEPROM
In-Reply-To: <20170615185418.13980-1-javier@dowhile0.org>
References: <20170615185418.13980-1-javier@dowhile0.org>
Message-ID: <20170615185418.13980-8-javier@dowhile0.org>
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
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

---

Changes in v5:
- Only replace atmel variant but keep other EEPROM vendors (Geert Uytterhoeven).

Changes in v4:
- Only use the atmel manufacturer in the compatible string instead of
  keeping the deprecated ones (Rob Herring).

Changes in v3:
- Add Geert Uytterhoeven reviewed-by tag.

Changes in v2: None

 arch/arm/boot/dts/r8a7791-koelsch.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
index 001e6116c47c..dc8ed02de707 100644
--- a/arch/arm/boot/dts/r8a7791-koelsch.dts
+++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
@@ -702,7 +702,7 @@
 	};
 
 	eeprom at 50 {
-		compatible = "renesas,24c02";
+		compatible = "renesas,24c02", "atmel,24c02";
 		reg = <0x50>;
 		pagesize = <16>;
 	};
-- 
2.9.3
