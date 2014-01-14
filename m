From: sebastien.szymanski@armadeus.com (=?UTF-8?q?S=C3=A9bastien=20Szymanski?=)
Date: Tue, 14 Jan 2014 15:21:27 +0100
Subject: [PATCH] ARM: dts: imx28-apf28dev: add user button
Message-ID: <1389709287-25742-1-git-send-email-sebastien.szymanski@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: S?bastien Szymanski <sebastien.szymanski@armadeus.com>
---
 arch/arm/boot/dts/imx28-apf28dev.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index 334dea5..221cac4 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -48,6 +48,7 @@
 						MX28_PAD_LCD_D20__GPIO_1_20
 						MX28_PAD_LCD_D21__GPIO_1_21
 						MX28_PAD_LCD_D22__GPIO_1_22
+						MX28_PAD_GPMI_CE1N__GPIO_0_17
 					>;
 					fsl,drive-strength = <MXS_DRIVE_4mA>;
 					fsl,voltage = <MXS_VOLTAGE_HIGH>;
@@ -193,4 +194,14 @@
 		brightness-levels = <0 4 8 16 32 64 128 255>;
 		default-brightness-level = <6>;
 	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+
+		user-button {
+			label = "User button";
+			gpios = <&gpio0 17 0>;
+			linux,code = <0x100>;
+		};
+	};
 };
-- 
1.8.3.2
