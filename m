From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue,  5 Apr 2016 08:35:54 +0200
Subject: [PATCH 5/6] ARM: dts: pxa: add pinctrl to pxa3xx
In-Reply-To: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
References: <1459838155-28803-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1459838155-28803-5-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pincontrol to pxa3xx, based on pinconf-simple.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa3xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index 5e2dea0f1436..6995b11ce042 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -43,6 +43,15 @@
 			marvell,intc-nr-irqs = <56>;
 		};
 
+		pinctrl: pinctrl at 40e10000 {
+			compatible = "pinconf-single";
+			reg = <0x40e10000 0xffff>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			pinctrl-single,register-width = <32>;
+			pinctrl-single,function-mask = <0x7>;
+		};
+
 		gpio: gpio at 40e00000 {
 			compatible = "intel,pxa3xx-gpio";
 			reg = <0x40e00000 0x10000>;
-- 
2.1.4
