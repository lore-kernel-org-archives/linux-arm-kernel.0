From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  1 Feb 2017 09:53:23 +0100
Subject: [PATCH v3 2/2] ARM: sun8i: dt: Add mali node
In-Reply-To: <b098c4fa9fce88361cca20417978734d0e1b5cca.1485939041.git-series.maxime.ripard@free-electrons.com>
References: <b098c4fa9fce88361cca20417978734d0e1b5cca.1485939041.git-series.maxime.ripard@free-electrons.com>
Message-ID: <82ff2fdb784b1444c8dc4a2d85f17522b9187741.1485939041.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A23 and A33 have an ARM Mali 400 GPU. Now that we have a binding, add
it to our DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

---

Changes from v2:
  - Removed leading 0 from the unit address
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index d92fdf5a7b26..35008b78d899 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -472,6 +472,32 @@
 			#size-cells = <0>;
 		};
 
+		mali: gpu at 1c40000 {
+			compatible = "allwinner,sun8i-a23-mali",
+				     "allwinner,sun7i-a20-mali", "arm,mali-400";
+			reg = <0x01c40000 0x10000>;
+			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "gp",
+					  "gpmmu",
+					  "pp0",
+					  "ppmmu0",
+					  "pp1",
+					  "ppmmu1",
+					  "pmu";
+			clocks = <&ccu CLK_BUS_GPU>, <&ccu CLK_GPU>;
+			clock-names = "bus", "core";
+			resets = <&ccu RST_BUS_GPU>;
+
+			assigned-clocks = <&ccu CLK_GPU>;
+			assigned-clock-rates = <408000000>;
+		};
+
 		gic: interrupt-controller at 01c81000 {
 			compatible = "arm,cortex-a7-gic", "arm,cortex-a15-gic";
 			reg = <0x01c81000 0x1000>,
-- 
git-series 0.8.11
