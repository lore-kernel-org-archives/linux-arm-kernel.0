From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Thu, 16 Mar 2017 01:28:08 +0800
Subject: [PATCH v2 5/5] arm64: allwinner: a64: add R_PIO pinctrl node
In-Reply-To: <20170315172808.64011-1-icenowy@aosc.xyz>
References: <20170315172808.64011-1-icenowy@aosc.xyz>
Message-ID: <20170315172808.64011-6-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 have a dedicated pin controller to manage the PL pin bank.
As the driver and the required clock support are added, add the device
node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
New patch in v2.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index dbeba43386f6..a59fec6f2a22 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -410,5 +410,17 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun50i-a64-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu CLK_APB0_PIO>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
 	};
 };
-- 
2.12.0
