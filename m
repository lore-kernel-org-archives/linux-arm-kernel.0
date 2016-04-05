From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  5 Apr 2016 08:35:50 +0200
Subject: [PATCH 1/6] ARM: dts: pxa: add pxa framebuffer device
Message-ID: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the framebuffer device, or display controller, available on pxa2xx
and pxa3xx platforms.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa2xx.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 5e5af078b9b5..3ff077ca4400 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -140,5 +140,13 @@
 			reg = <0x40900000 0x3c>;
 			interrupts = <30 31>;
 		};
+
+		lcd-controller at 40500000 {
+			compatible = "marvell,pxa2xx-lcdc";
+			reg = <0x44000000 0x10000>;
+			interrupts = <17>;
+			clocks = <&clks CLK_LCD>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.1.4
