From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 31 Jan 2015 23:48:29 +0100
Subject: [PATCH 4/5] ARM: dts: pxa: add pxa27x-keypad to pxa27x
In-Reply-To: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
References: <1422744510-3179-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1422744510-3179-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa27x has an embedded keypad controller. Add it in the pxa27x
device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 979560c..7f93828 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -73,6 +73,15 @@
 			status = "disabled";
 		};
 
+		keypad: keypad at 41500000 {
+			compatible = "marvell,pxa27x-keypad";
+			reg = <0x41500000 0x4c>;
+			interrupts = <4>;
+			clocks = <&pxa2xx_clks CLK_KEYPAD>;
+			status = "disabled";
+		};
+	};
+
 	clocks {
 	       /*
 		* The muxing of external clocks/internal dividers for osc* clock
-- 
2.1.0
