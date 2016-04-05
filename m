From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  5 Apr 2016 08:35:53 +0200
Subject: [PATCH 4/6] ARM: dts: pxa: fix the ohci clock for pxa3xx
In-Reply-To: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
References: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1459838155-28803-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the USB host clock, which is CLK_USBH. CLK_USBHOST is the clock of
the usb host of pxa27x SoCs.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 5767ed4957ae..5e2dea0f1436 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -92,7 +92,7 @@
 			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
-			clocks = <&clks CLK_USBHOST>;
+			clocks = <&clks CLK_USBH>;
 			status = "disabled";
 		};
 
-- 
2.1.4
