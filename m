From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 28 Aug 2017 10:19:57 +0300
Subject: [PATCH] ARM: dts: keystone-k2g: Add McASP nodes
Message-ID: <20170828071957.9597-1-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

?Add three McASP nodes present on 66AK2G device.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
Hi Santosh,

There is no driver change dependency for McASP to work on 66AK2G, only the nodes
need to be in place.

Regards,
Peter

 arch/arm/boot/dts/keystone-k2g.dtsi | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g.dtsi b/arch/arm/boot/dts/keystone-k2g.dtsi
index 826b286665e6..5fcd2c6da46d 100644
--- a/arch/arm/boot/dts/keystone-k2g.dtsi
+++ b/arch/arm/boot/dts/keystone-k2g.dtsi
@@ -343,5 +343,53 @@
 			clock-names = "fck", "mmchsdb_fck";
 			status = "disabled";
 		};
+
+		mcasp0: mcasp at 02340000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			reg = <0x02340000 0x2000>,
+			      <0x21804000 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma0 24 1>, <&edma0 25 1>;
+			dma-names = "tx", "rx";
+			power-domains = <&k2g_pds 0x4>;
+			clocks = <&k2g_clks 0x4 0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
+		mcasp1: mcasp at 02342000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			reg = <0x02342000 0x2000>,
+			      <0x21804400 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma1 48 1>, <&edma1 49 1>;
+			dma-names = "tx", "rx";
+			power-domains = <&k2g_pds 0x5>;
+			clocks = <&k2g_clks 0x5 0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
+		mcasp2: mcasp at 02344000 {
+			compatible = "ti,am33xx-mcasp-audio";
+			reg = <0x02344000 0x2000>,
+			      <0x21804800 0x1000>;
+			reg-names = "mpu","dat";
+			interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&edma1 50 1>, <&edma1 51 1>;
+			dma-names = "tx", "rx";
+			power-domains = <&k2g_pds 0x6>;
+			clocks = <&k2g_clks 0x6 0>;
+			clock-names = "fck";
+			status = "disabled";
+		};
 	};
 };
-- 
2.14.1


Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
