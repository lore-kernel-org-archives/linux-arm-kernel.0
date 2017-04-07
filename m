From: icenowy@aosc.io (Icenowy Zheng)
Date: Sat,  8 Apr 2017 02:34:32 +0800
Subject: [PATCH v2 02/11] arm64: allwinner: a64: add NMI controller on A64
In-Reply-To: <20170407183441.58750-1-icenowy@aosc.io>
References: <20170407183441.58750-1-icenowy@aosc.io>
Message-ID: <20170407183441.58750-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC features a NMI controller, which is usually connected
to the AXP PMIC.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
Changes in v2:
- Added Chen-Yu's ACK.

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 05ec9fc5e81f..53c18ca372ea 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -403,6 +403,14 @@
 				     <GIC_SPI 41 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		nmi_intc: interrupt-controller at 01f00c0c {
+			compatible = "allwinner,sun6i-a31-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01f00c0c 0x38>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun50i-a64-r-ccu";
 			reg = <0x01f01400 0x100>;
-- 
2.12.2
