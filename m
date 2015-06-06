From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  6 Jun 2015 23:09:13 +0200
Subject: [PATCH 6/6] ARM: dts: pxa: add the usb host controller
In-Reply-To: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
References: <1433624953-28165-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1433624953-28165-6-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the usb host controller to pxa27x and pxa3xx.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
 arch/arm/boot/dts/pxa3xx.dtsi | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 94cf80f..7f75272 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -26,6 +26,14 @@
 			clocks = <&clks CLK_NONE>;
 		};
 
+		pxa27x_ohci: ohci at 4c000000 {
+			compatible = "marvell,pxa-ohci";
+			reg = <0x4c000000 0x10000>;
+			interrupts = <3>;
+			clocks = <&clks CLK_USBHOST>;
+			status = "disabled";
+		};
+
 		pwm0: pwm at 40b00000 {
 			compatible = "marvell,pxa270-pwm", "marvell,pxa250-pwm";
 			reg = <0x40b00000 0x10>;
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 29aeac5..67bd4fe 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -86,6 +86,14 @@
 			dma-names = "rx", "tx";
 			status = "disabled";
 		};
+
+		pxa3xx_ohci: ohci at 4c000000 {
+			compatible = "marvell,pxa-ohci";
+			reg = <0x4c000000 0x10000>;
+			interrupts = <3>;
+			clocks = <&clks CLK_USBHOST>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.4
