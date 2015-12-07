From: ilya@compulab.co.il (Ilya Ledvich)
Date: Mon,  7 Dec 2015 09:14:36 +0200
Subject: [PATCH 5/8] ARM: dts: imx7d: cl-som-imx7: add eeprom support
In-Reply-To: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
References: <1449472479-2521-1-git-send-email-ilya@compulab.co.il>
Message-ID: <1449472479-2521-6-git-send-email-ilya@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for the module EEPROM over I2C2 bus.

Signed-off-by: Ilya Ledvich <ilya@compulab.co.il>
Acked-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/boot/dts/imx7d-cl-som-imx7.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
index 97e96c6..b938d9e 100644
--- a/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
+++ b/arch/arm/boot/dts/imx7d-cl-som-imx7.dts
@@ -159,6 +159,12 @@
 			};
 		};
 	};
+
+	eeprom at 50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 &uart1 {
-- 
1.9.1
