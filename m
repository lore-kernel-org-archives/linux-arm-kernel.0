From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Wed, 13 Apr 2016 20:01:55 +0800
Subject: [PATCH 7/7] arm64: dts: mediatek: Add Video Encoder for MT8173
In-Reply-To: <1460548915-17536-7-git-send-email-tiffany.lin@mediatek.com>
References: <1460548915-17536-1-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-2-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-3-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-4-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-5-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-6-git-send-email-tiffany.lin@mediatek.com>
 <1460548915-17536-7-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1460548915-17536-8-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add video decoder node for MT8173

Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   38 ++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 26aeffe..32b555e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -1124,6 +1124,44 @@
 			#clock-cells = <1>;
 		};
 
+		vcodec_dec: vcodec at 16000000 {
+			compatible = "mediatek,mt8173-vcodec-dec";
+			reg = <0 0x16000000 0 0x100>,	/* VDEC_SYS */
+			      <0 0x16020000 0 0x1000>,	/* VDEC_MISC */
+			      <0 0x16021000 0 0x800>,	/* VDEC_LD */
+			      <0 0x16021800 0 0x800>,	/* VDEC_TOP */
+			      <0 0x16022000 0 0x1000>,	/* VDEC_CM */
+			      <0 0x16023000 0 0x1000>,	/* VDEC_AD */
+			      <0 0x16024000 0 0x1000>,	/* VDEC_AV */
+			      <0 0x16025000 0 0x1000>,	/* VDEC_PP */
+			      <0 0x16026800 0 0x800>,	/* VDEC_HWD */
+			      <0 0x16027000 0 0x800>,	/* VDEC_HWQ */
+			      <0 0x16027800 0 0x800>,	/* VDEC_HWB */
+			      <0 0x16028400 0 0x400>;	/* VDEC_HWG */
+			interrupts = <GIC_SPI 204 IRQ_TYPE_LEVEL_LOW>;
+			mediatek,larb = <&larb1>;
+			iommus = <&iommu M4U_PORT_HW_VDEC_MC_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PP_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_AVC_MV_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PRED_RD_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_PRED_WR_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_UFO_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_VLD_EXT>,
+				 <&iommu M4U_PORT_HW_VDEC_VLD2_EXT>;
+			mediatek,vpu = <&vpu>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+			clocks = <&apmixedsys CLK_APMIXED_VCODECPLL>,
+				 <&topckgen CLK_TOP_UNIVPLL_D2>,
+				 <&topckgen CLK_TOP_CCI400_SEL>,
+				 <&topckgen CLK_TOP_VDEC_SEL>,
+				 <&topckgen CLK_TOP_VCODECPLL>;
+			clock-names = "vcodecpll",
+				      "univpll_d2",
+				      "clk_cci400_sel",
+				      "vdec_sel",
+				      "vdecpll";
+		};
+
 		larb1: larb at 16010000 {
 			compatible = "mediatek,mt8173-smi-larb";
 			reg = <0 0x16010000 0 0x1000>;
-- 
1.7.9.5
