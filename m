From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 18:00:09 +0800
Subject: [PATCH 8/8] arm64: dts: allwinner: add PWM node to A64 dtsi
In-Reply-To: <20170208100009.29362-1-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
Message-ID: <20170208100009.29362-8-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 has also a PWM controller on PD22 (not available on
Pine64, because it's muxed with EMAC, but it's used on Olimex TERES
laptop kit to adjust the screen backlight).

Add a device node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 6e34f5adcf06..078322fb5d58 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -296,6 +296,14 @@
 			};
 		};
 
+		pwm: pwm at 1c21400 {
+			compatible = "allwinner,sun8i-h3-pwm";
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
2.11.0
