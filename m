From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 26 May 2017 16:00:25 +0800
Subject: [PATCH 3/3] ARM: sun8i: a83t: Add device node for PRCM
In-Reply-To: <20170526080025.28532-1-wens@csie.org>
References: <20170526080025.28532-1-wens@csie.org>
Message-ID: <20170526080025.28532-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A83T's PRCM has the same set of clocks and resets as the A64.
However, a few dividers are different. And due to the lack of a low
speed 32.768 kHz oscillator, a few of the clock parents are different.

The PRCM also has controls for various power domains. These are not
supported yet, neither in software nor in the device tree binding.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 1dc4cfe81534..8089f36deeff 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -270,5 +270,14 @@
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_HIGH)>;
 		};
+
+		r_ccu: clock at 1f01400 {
+			compatible = "allwinner,sun8i-a83t-r-ccu";
+			reg = <0x01f01400 0x400>;
+			clocks = <&osc24M>, <&osc16Md512>, <&osc16M>;
+			clock-names = "hosc", "losc", "iosc";
+			#clock-cells = <1>;
+			#reset-cells = <1>;
+		};
 	};
 };
-- 
2.11.0
