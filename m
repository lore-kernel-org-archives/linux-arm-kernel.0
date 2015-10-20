From: puck.chen@hisilicon.com (Chen Feng)
Date: Tue, 20 Oct 2015 16:45:24 +0800
Subject: [PATCH V2 3/3] Add dts node for smmu on hi6220 SoC
In-Reply-To: <1445330724-129401-1-git-send-email-puck.chen@hisilicon.com>
References: <1445330724-129401-1-git-send-email-puck.chen@hisilicon.com>
Message-ID: <1445330724-129401-3-git-send-email-puck.chen@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: Add dts node for hi6220 smmu driver

Signed-off-by: Chen Feng <puck.chen@hisilicon.com>
Signed-off-by: Yu Dongbin <yudongbin@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..3ef33b4 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/clock/hi6220-clock.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -167,5 +168,19 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
+
+		smmu at f4210000 {
+			compatible = "hisilicon,hi6220-smmu";
+			reg = <0x0 0xf4210000 0x0 0x1000>;
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&sys_ctrl HI6220_MMU_CLK>,
+				 <&media_ctrl HI6220_MED_MMU>,
+				 <&sys_ctrl HI6220_MEDIA_PLL_SRC>;
+			clock-names = "smmu_clk",
+				      "media_sc_clk",
+				      "smmu_peri_clk";
+			#iommu-cells = <1>;
+		};
+
 	};
 };
-- 
1.9.1
