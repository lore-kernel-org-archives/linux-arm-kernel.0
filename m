From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Mon, 27 Aug 2012 16:39:59 -0300
Subject: [PATCH] ARM: mx28evk: Add I2C EEPROM support
Message-ID: <1346096399-10114-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mx28evk has a free slot U50 that can be used to populate an I2C EEPROM.

Add support for it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx28-evk.dts |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index ed92d61..a0ad71c 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -161,6 +161,12 @@
 					VDDIO-supply = <&reg_3p3v>;
 
 				};
+
+				at24 at 51 {
+					compatible = "at24,24c32";
+					pagesize = <32>;
+					reg = <0x51>;
+				};
 			};
 
 			pwm: pwm at 80064000 {
-- 
1.7.9.5
