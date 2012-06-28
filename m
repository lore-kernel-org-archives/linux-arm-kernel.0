From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 28 Jun 2012 15:53:49 +0200
Subject: [PATCH v2 4/4] ARM: dts: imx23,28: limit usb to host role
In-Reply-To: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
References: <1340891629-13145-1-git-send-email-mkl@pengutronix.de>
Message-ID: <1340891629-13145-5-git-send-email-mkl@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The driver just supports host for now.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 arch/arm/boot/dts/imx23.dtsi |    1 +
 arch/arm/boot/dts/imx28.dtsi |    2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/imx23.dtsi b/arch/arm/boot/dts/imx23.dtsi
index 8c5f999..c482a5a 100644
--- a/arch/arm/boot/dts/imx23.dtsi
+++ b/arch/arm/boot/dts/imx23.dtsi
@@ -289,6 +289,7 @@
 
 		usbctrl at 80080000 {
 			reg = <0x80080000 0x10000>;
+			dr_mode = "host";
 			status = "disabled";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 4634cb8..da0972d 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -461,11 +461,13 @@
 
 		usbctrl0: usbctrl at 80080000 {
 			reg = <0x80080000 0x10000>;
+			dr_mode = "host";
 			status = "disabled";
 		};
 
 		usbctrl1: usbctrl at 80090000 {
 			reg = <0x80090000 0x10000>;
+			dr_mode = "host";
 			status = "disabled";
 		};
 
-- 
1.7.10
