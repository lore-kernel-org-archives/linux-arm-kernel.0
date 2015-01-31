From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jan 2015 23:48:28 +0100
Subject: [PATCH 3/5] ARM: dts: pxa: add pxa27x-udc to pxa27x
In-Reply-To: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1422744510-3179-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa27x has an embedded usb udc controller. Add it in the pxa27x
device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 7cbf36f..979560c 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -65,6 +65,14 @@
 			clocks = <&pxa2xx_clks CLK_I2C>;
 		};
 
+		pxa27x_udc: udc at 40600000 {
+			compatible = "marvell,pxa270-udc";
+			reg = <0x40600000 0x10000>;
+			interrupts = <11>;
+			clocks = <&pxa2xx_clks CLK_USB>;
+			status = "disabled";
+		};
+
 	clocks {
 	       /*
 		* The muxing of external clocks/internal dividers for osc* clock
-- 
2.1.0
