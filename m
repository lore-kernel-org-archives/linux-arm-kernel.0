From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  5 Apr 2016 08:35:52 +0200
Subject: [PATCH 3/6] ARM: dts: add pincontroller to pxa27x
In-Reply-To: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
References: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1459838155-28803-3-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the new pincontrol driver to pxa27x based boards.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 210192c38df3..9e73dc6b3ed3 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -22,8 +22,15 @@
 			marvell,intc-nr-irqs = <34>;
 		};
 
+		pinctrl: pinctrl at 40e00000 {
+			reg = <0x40e00054 0x20 0x40e0000c 0xc 0x40e0010c 4
+			       0x40f00020 0x10>;
+			compatible = "marvell,pxa27x-pinctrl";
+		};
+
 		gpio: gpio at 40e00000 {
 			compatible = "intel,pxa27x-gpio";
+			gpio-ranges = <&pinctrl 0 0 128>;
 			clocks = <&clks CLK_NONE>;
 		};
 
-- 
2.1.4
