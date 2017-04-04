From: icenowy@aosc.io (Icenowy Zheng)
Date: Tue,  4 Apr 2017 17:51:00 +0800
Subject: [PATCH v4 5/5] arm64: allwinner: a64: add R_PIO pinctrl node
In-Reply-To: <20170404095100.18649-1-icenowy@aosc.io>
References: <20170404095100.18649-1-icenowy@aosc.io>
Message-ID: <20170404095100.18649-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Icenowy Zheng <icenowy@aosc.xyz>

Allwinner A64 have a dedicated pin controller to manage the PL pin bank.
As the driver and the required clock support are added, add the device
node for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 1d4e5bcced0c..6bc606b4d74d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -409,5 +409,17 @@
 			#clock-cells = <1>;
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun50i-a64-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&r_ccu 3>, <&osc24M>, <&osc32k>;
+			clock-names = "apb", "hosc", "losc";
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
 	};
 };
-- 
2.12.2
