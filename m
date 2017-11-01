From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 1 Nov 2017 11:03:31 +0200
Subject: [PATCH] ARM: dts: am4372: Correct the interrupts_properties of McASP
Message-ID: <20171101090331.15435-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fixes the following wanring:
arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp at 44000000/mcasp at 48038000
arch/arm/boot/dts/am437x-cm-t43.dtb: Warning (interrupts_property): interrupts size is (8), expected multiple of 12 in /ocp at 44000000/mcasp at 4803C000

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index e5b061469bf8..4714a59fd86d 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -927,7 +927,8 @@
 			reg = <0x48038000 0x2000>,
 			      <0x46000000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <80>, <81>;
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 8 2>,
@@ -941,7 +942,8 @@
 			reg = <0x4803C000 0x2000>,
 			      <0x46400000 0x400000>;
 			reg-names = "mpu", "dat";
-			interrupts = <82>, <83>;
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "tx", "rx";
 			status = "disabled";
 			dmas = <&edma 10 2>,
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
