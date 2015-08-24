From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Mon, 24 Aug 2015 10:19:58 +0300
Subject: [PATCH 02/11] ARM: DTS: dra7: Add McASP3 node
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <1440400807-32274-3-git-send-email-peter.ujfalusi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d65db9ebc2b..07fa4ea5521a 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1403,6 +1403,21 @@
 			status = "disabled";
 		};
 
+		mcasp3: mcasp at 48468000 {
+			compatible = "ti,dra7-mcasp-audio";
+			ti,hwmods = "mcasp3";
+			reg = <0x48468000 0x2000>;
+			reg-names = "mpu";
+			interrupts = <GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "tx", "rx";
+			dmas = <&sdma_xbar 133>, <&sdma_xbar 132>;
+			dma-names = "tx", "rx";
+			clocks = <&mcasp3_ahclkx_mux>;
+			clock-names = "fck";
+			status = "disabled";
+		};
+
 		crossbar_mpu: crossbar at 4a002a48 {
 			compatible = "ti,irq-crossbar";
 			reg = <0x4a002a48 0x130>;
-- 
2.5.0
