From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 12 Feb 2015 18:22:37 +0100
Subject: [PATCH v4 4/5] ARM: dts: pxa: add pxa27x-keypad to pxa27x
In-Reply-To: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
References: <1423761758-29159-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <1423761758-29159-4-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Each pxa27x has an embedded keypad controller. Add it in the pxa27x
device-tree description.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa27x.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 7cc36ef..74f7df7 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -60,6 +60,14 @@
 			clocks = <&clks CLK_USB>;
 			status = "disabled";
 		};
+
+		keypad: keypad at 41500000 {
+			compatible = "marvell,pxa27x-keypad";
+			reg = <0x41500000 0x4c>;
+			interrupts = <4>;
+			clocks = <&clks CLK_KEYPAD>;
+			status = "disabled";
+		};
 	};
 
 	clocks {
-- 
2.1.0
