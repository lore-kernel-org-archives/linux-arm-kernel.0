From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Feb 2015 13:39:18 +0100
Subject: [PATCH v3 3/5] ARM: dts: pxa: add pxa27x-udc to pxa27x
In-Reply-To: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
References: <1423312760-15871-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423312760-15871-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa27x has an embedded usb udc controller. Add it in the pxa27x
device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index e8d5097..ddb6982 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -68,6 +68,14 @@
 		pxai2c1: i2c at 40301680 {
 			clocks = <&pxa2xx_clks CLK_I2C>;
 		};
+
+		pxa27x_udc: udc at 40600000 {
+			compatible = "marvell,pxa270-udc";
+			reg = <0x40600000 0x10000>;
+			interrupts = <11>;
+			clocks = <&pxa2xx_clks CLK_USB>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.0
