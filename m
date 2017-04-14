From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Thu, 13 Apr 2017 22:04:37 -0300
Subject: [PATCH v3 13/21] ARM: dts: uniphier: Add generic compatible string
 for I2C EEPROM
In-Reply-To: <20170414010445.21727-1-javier@osg.samsung.com>
References: <20170414010445.21727-1-javier@osg.samsung.com>
Message-ID: <20170414010445.21727-14-javier@osg.samsung.com>
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

 arch/arm/boot/dts/uniphier-pro4-ace.dts    | 2 +-
 arch/arm/boot/dts/uniphier-pro4-sanji.dts  | 2 +-
 arch/arm/boot/dts/uniphier-pxs2-gentil.dts | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-pro4-ace.dts b/arch/arm/boot/dts/uniphier-pro4-ace.dts
index fefc89149234..b9a4919d7c93 100644
--- a/arch/arm/boot/dts/uniphier-pro4-ace.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-ace.dts
@@ -88,7 +88,7 @@
 	status = "okay";
 
 	eeprom at 54 {
-		compatible = "st,24c64";
+		compatible = "st,24c64", "atmel,24c64";
 		reg = <0x54>;
 		pagesize = <32>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pro4-sanji.dts b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
index 6c63c8bad825..3950baa8d55d 100644
--- a/arch/arm/boot/dts/uniphier-pro4-sanji.dts
+++ b/arch/arm/boot/dts/uniphier-pro4-sanji.dts
@@ -83,7 +83,7 @@
 	status = "okay";
 
 	eeprom at 54 {
-		compatible = "st,24c64";
+		compatible = "st,24c64", "atmel,24c64";
 		reg = <0x54>;
 		pagesize = <32>;
 	};
diff --git a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
index cccc86658d20..afba587ffbbc 100644
--- a/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
+++ b/arch/arm/boot/dts/uniphier-pxs2-gentil.dts
@@ -80,7 +80,7 @@
 	status = "okay";
 
 	eeprom at 54 {
-		compatible = "st,24c64";
+		compatible = "st,24c64", "atmel,24c64";
 		reg = <0x54>;
 		pagesize = <32>;
 	};
-- 
2.9.3
