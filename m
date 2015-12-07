From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:37 +0200
Subject: [PATCH 6/8] ARM: dts: imx7d: cl-som-imx7: add gpio extender support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-7-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for PCA9555 GPIO extender over I2C2 bus.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index b938d9e..30bbdcd 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -160,6 +160,13 @@
 		};
 	};
 
+	pca9555: pca9555 at 20 {
+		compatible = "nxp,pca9555";
+		gpio-controller;
+		#gpio-cells = <2>;
+		reg = <0x20>;
+	};
+
 	eeprom at 50 {
 		compatible = "atmel,24c08";
 		reg = <0x50>;
-- 
1.9.1
