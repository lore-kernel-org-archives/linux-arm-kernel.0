From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jun 2017 13:59:30 +0800
Subject: [PATCH 08/10] ARM: sun8i: a23/a33: Use new sun6i-a31-r-intc
 compatible for NMI/R_INTC
In-Reply-To: <20170606055932.22548-1-wens@csie.org>
References: <20170606055932.22548-1-wens@csie.org>
Message-ID: <20170606055932.22548-9-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We introduced a new compatible for the NMI or R_INTC interrupt
controller. This new compatible has the register region aligned
to the boundary listed in the SoC's memory map.

This patch converts the NMI/R_INTC node to using the new compatible,
and fixes up the register region and device node name.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a8b978d0f35b..ea50dda75adc 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -519,11 +519,11 @@
 			#clock-cells = <1>;
 		};
 
-		nmi_intc: interrupt-controller at 01f00c0c {
-			compatible = "allwinner,sun6i-a31-sc-nmi";
+		nmi_intc: interrupt-controller at 1f00c00 {
+			compatible = "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
 			#interrupt-cells = <2>;
-			reg = <0x01f00c0c 0x38>;
+			reg = <0x01f00c00 0x400>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-- 
2.11.0
