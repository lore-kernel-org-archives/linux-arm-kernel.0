From: otavio@ossystems.com.br (Otavio Salvador)
Date: Tue, 16 Jul 2013 09:56:12 -0300
Subject: [PATCH v2 1/4] ARM: dts: imx23-evk: enable USB PHY and controller
Message-ID: <1373979376-31583-1-git-send-email-otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i.MX23EVK board provides a USB port so the USB PHY and controller
need to be enabled for it to be usable.

Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---
Changes in v2: None

 arch/arm/boot/dts/imx23-evk.dts | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/imx23-evk.dts b/arch/arm/boot/dts/imx23-evk.dts
index da0588a..dc3ab45 100644
--- a/arch/arm/boot/dts/imx23-evk.dts
+++ b/arch/arm/boot/dts/imx23-evk.dts
@@ -107,6 +107,16 @@
 				pinctrl-0 = <&duart_pins_a>;
 				status = "okay";
 			};
+
+			usbphy0: usbphy at 8007c000 {
+				status = "okay";
+			};
+		};
+	};
+
+	ahb at 80080000 {
+		usb0: usb at 80080000 {
+			status = "okay";
 		};
 	};
 
-- 
1.8.3.2
