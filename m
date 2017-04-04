From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed,  5 Apr 2017 02:01:36 +0800
Subject: [PATCH 02/11] arm64: allwinner: a64: add NMI controller on A64
In-Reply-To: <20170404180145.12897-1-icenowy@aosc.io>
References: <20170404180145.12897-1-icenowy@aosc.io>
Message-ID: <20170404180145.12897-3-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner A64 SoC features a NMI controller, which is usually connected
to the AXP PMIC.

Add support for it.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 9a75b1c7c91a..f907a64e6f0c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -401,6 +401,14 @@
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
