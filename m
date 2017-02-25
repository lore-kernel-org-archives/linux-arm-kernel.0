From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Sat, 25 Feb 2017 15:42:16 +0800
Subject: [PATCH 3/3] arm64: dts: allwinner: add pwm device node for A64
In-Reply-To: <20170225074216.64868-1-icenowy@aosc.xyz>
References: <20170225074216.64868-1-icenowy@aosc.xyz>
Message-ID: <20170225074216.64868-3-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 features a PWM controller, which is used for backlight
control by several boards (Pine64 Pinebook, Olimex TERES I).

Add its device node.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 601514ead28c..afc76d5df4e2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -302,6 +302,14 @@
 			};
 		};
 
+		pwm: pwm at 01c21400 {
+			compatible = "allwinner,sun50i-a64-pwm";
+			reg = <0x01c21400 0x8>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
+
 		uart0: serial at 1c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
-- 
2.11.1
