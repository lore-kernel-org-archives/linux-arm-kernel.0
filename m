From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 26 Apr 2017 23:20:17 +0800
Subject: [PATCH v5 04/10] arm64: allwinner: a64: add NMI (R_INTC) controller
 on A64
In-Reply-To: <20170426152023.41567-1-icenowy@aosc.io>
References: <20170426152023.41567-1-icenowy@aosc.io>
Message-ID: <20170426152023.41567-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC features a R_INTC controller, which controls the NMI
line, and this interrupt line is usually connected to the AXP PMIC.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v4:
- Changes it to use R_INTC binding and change node label to r_intc.
- Fixed MMIO region.
- Dropped Chen-Yu's ACK due to big change.
Changes in v2:
- Added Chen-Yu's ACK.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 05ec9fc5e81f..a6566d292934 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -403,6 +403,14 @@
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		r_intc: interrupt-controller at 1f00c00 {
+			compatible = "allwinner,sun50i-a64-r-intc";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c00 0x400>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun50i-a64-r-ccu";
 			reg = <0x01f01400 0x100>;
-- 
2.12.2
