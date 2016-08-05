From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri,  5 Aug 2016 16:55:21 +0200
Subject: [PATCH 4/4] arm64: dts: marvell: describe the PIC and PMU on Armada
 7K/8K
In-Reply-To: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1470408921-447-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1470408921-447-5-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit adds the necessary Device Tree description for the PIC
interrupt controller and the PMU available in the Marvell Armada 7K and
Armada 8K SoCs.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm64/boot/dts/marvell/armada-ap806.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
index eab1a42..e70b996 100644
--- a/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-ap806.dtsi
@@ -128,6 +128,12 @@
 					     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_EDGE_RISING)>;
 			};
 
+			pmu {
+				compatible = "arm,cortex-a72-pmu";
+				interrupt-parent = <&pic>;
+				interrupts = <17>;
+			};
+
 			odmi: odmi at 300000 {
 				compatible = "marvell,odmi-controller";
 				interrupt-controller;
@@ -140,6 +146,14 @@
 				marvell,spi-base = <128>, <136>, <144>, <152>;
 			};
 
+			pic: interrupt-controller at 3f0100 {
+				compatible = "marvell,armada-8k-pic";
+				reg = <0x3f0100 0x10>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+				interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			xor at 400000 {
 				compatible = "marvell,armada-7k-xor", "marvell,xor-v2";
 				reg = <0x400000 0x1000>,
-- 
2.7.4
