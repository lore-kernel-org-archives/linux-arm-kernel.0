From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Wed,  8 Feb 2017 18:00:07 +0800
Subject: [PATCH 6/8] arm64: dts: allwinner: add device node for R_PWM
In-Reply-To: <20170208100009.29362-1-icenowy@aosc.xyz>
References: <20170208100009.29362-1-icenowy@aosc.xyz>
Message-ID: <20170208100009.29362-6-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC has two PWM controller, both are similar to the
controller in H3 SoC.

Add one of the controllers which lies in the "CPUs" part of the SoC.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 4b0baa79554c..6204aee5c6f4 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -432,5 +432,13 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 		};
+
+		r_pwm: pwm at 01f03800 {
+			compatible = "allwinner,sun8i-h3-pwm";
+			reg = <0x01f03800 0x8>;
+			clocks = <&osc24M>;
+			#pwm-cells = <3>;
+			status = "disabled";
+		};
 	};
 };
-- 
2.11.0
