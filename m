From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 15 May 2015 17:43:29 +0800
Subject: [PATCH v2 6/6] dts: mt8173: Add iommu/smi nodes for mt8173
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1431683009-18158-7-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add the iommu/larbs nodes for mt8173

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 79 ++++++++++++++++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 3fca624..95a8a15 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -16,6 +16,7 @@
 #include <dt-bindings/reset-controller/mt8173-resets.h>
 #include <dt-bindings/clock/mt8173-clk.h>
 #include <dt-bindings/power/mt8173-power.h>
+#include <dt-bindings/iommu/mt8173-iommu-port.h>
 #include "mt8173-pinfunc.h"
 
 / {
@@ -200,6 +201,22 @@
 			reg = <0 0x10200620 0 0x20>;
 		};
 
+		iommu: mmsys_iommu at 10205000 {
+			compatible = "mediatek,mt8173-m4u";
+			reg = <0 0x10205000 0 0x1000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_LOW>;
+			clocks = <&infracfg CLK_INFRA_M4U>;
+			clock-names = "bclk";
+			larb-portes-nr = <M4U_LARB0_PORT_NR
+					  M4U_LARB1_PORT_NR
+					  M4U_LARB2_PORT_NR
+					  M4U_LARB3_PORT_NR
+					  M4U_LARB4_PORT_NR
+					  M4U_LARB5_PORT_NR>;
+			larb = <&larb0 &larb1 &larb2 &larb3 &larb4 &larb5>;
+			#iommu-cells = <1>;
+		};
+
 		apmixedsys: apmixedsys at 10209000 {
 			compatible = "mediatek,mt8173-apmixedsys";
 			reg = <0 0x10209000 0 0x1000>;
@@ -258,6 +275,68 @@
 			clock-names = "baud", "bus";
 			status = "disabled";
 		};
+
+		larb0:larb at 14021000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x14021000 0 0x1000>;
+			smi = <&smi_common>;
+			clocks = <&mmsys MM_SMI_LARB0>,
+				 <&mmsys MM_SMI_LARB0>;
+			clock-names = "apb", "smi";
+		};
+
+		smi_common:smi at 14022000 {
+			compatible = "mediatek,mt8173-smi";
+			reg = <0 0x14022000 0 0x1000>;
+			clocks = <&mmsys MM_SMI_COMMON>,
+				 <&mmsys MM_SMI_COMMON>;
+			clock-names = "apb", "smi";
+		};
+
+		larb4:larb at 14027000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x14027000 0 0x1000>;
+			smi = <&smi_common>;
+			clocks = <&mmsys MM_SMI_LARB4>,
+				 <&mmsys MM_SMI_LARB4>;
+			clock-names = "apb", "smi";
+		};
+
+		larb2:larb at 15001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x15001000 0 0x1000>;
+			smi = <&smi_common>;
+			clocks = <&imgsys IMG_LARB2_SMI>,
+				 <&imgsys IMG_LARB2_SMI>;
+			clock-names = "apb", "smi";
+		};
+
+		larb1:larb at 16010000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x16010000 0 0x1000>;
+			smi = <&smi_common>;
+			clocks = <&vdecsys VDEC_CKEN>,
+				 <&vdecsys VDEC_LARB_CKEN>;
+			clock-names = "apb", "smi";
+		};
+
+		larb3:larb at 18001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x18001000 0 0x1000>;
+			smi = <&smi_common>;
+			clocks = <&vencsys VENC_CKE1>,
+				 <&vencsys VENC_CKE0>;
+			clock-names = "apb", "smi";
+		};
+
+		larb5:larb at 19001000 {
+			compatible = "mediatek,mt8173-smi-larb";
+			reg = <0 0x19001000 0 0x1000>;
+			smi = <&smi_common>;
+			clocks = <&vencltsys VENCLT_CKE1>,
+				 <&vencltsys VENCLT_CKE0>;
+			clock-names = "apb", "smi";
+		};
 	};
 
 };
-- 
1.8.1.1.dirty
