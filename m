From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Tue, 9 Aug 2016 21:58:57 +0800
Subject: [PATCH v3 4/4] arm64: dts: mediatek: Add MDP for MT8173
In-Reply-To: <1470751137-12403-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1470751137-12403-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1470751137-12403-5-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MDP node for MT8173

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   84 ++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 10f638f..cd93228 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -41,6 +41,14 @@
 		dpi0 = &dpi0;
 		dsi0 = &dsi0;
 		dsi1 = &dsi1;
+		mdp_rdma0 = &mdp_rdma0;
+		mdp_rdma1 = &mdp_rdma1;
+		mdp_rsz0 = &mdp_rsz0;
+		mdp_rsz1 = &mdp_rsz1;
+		mdp_rsz2 = &mdp_rsz2;
+		mdp_wdma0 = &mdp_wdma0;
+		mdp_wrot0 = &mdp_wrot0;
+		mdp_wrot1 = &mdp_wrot1;
 	};
 
 	cpus {
@@ -716,6 +724,82 @@
 			#clock-cells = <1>;
 		};
 
+		mdp {
+			compatible = "mediatek,mt8173-mdp";
+			#address-cells = <2>;
+			#size-cells = <2>;
+			ranges;
+			mediatek,vpu = <&vpu>;
+
+			mdp_rdma0: rdma at 14001000 {
+				compatible = "mediatek,mt8173-mdp-rdma";
+				reg = <0 0x14001000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+					 <&mmsys CLK_MM_MUTEX_32K>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+				iommus = <&iommu M4U_PORT_MDP_RDMA0>;
+				mediatek,larb = <&larb0>;
+			};
+
+			mdp_rdma1: rdma at 14002000 {
+				compatible = "mediatek,mt8173-mdp-rdma";
+				reg = <0 0x14002000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_RDMA1>,
+					 <&mmsys CLK_MM_MUTEX_32K>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+				iommus = <&iommu M4U_PORT_MDP_RDMA1>;
+				mediatek,larb = <&larb4>;
+			};
+
+			mdp_rsz0: rsz at 14003000 {
+				compatible = "mediatek,mt8173-mdp-rsz";
+				reg = <0 0x14003000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_RSZ0>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			};
+
+			mdp_rsz1: rsz at 14004000 {
+				compatible = "mediatek,mt8173-mdp-rsz";
+				reg = <0 0x14004000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_RSZ1>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			};
+
+			mdp_rsz2: rsz at 14005000 {
+				compatible = "mediatek,mt8173-mdp-rsz";
+				reg = <0 0x14005000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_RSZ2>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			};
+
+			mdp_wdma0: wdma at 14006000 {
+				compatible = "mediatek,mt8173-mdp-wdma";
+				reg = <0 0x14006000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_WDMA>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+				iommus = <&iommu M4U_PORT_MDP_WDMA>;
+				mediatek,larb = <&larb0>;
+			};
+
+			mdp_wrot0: wrot at 14007000 {
+				compatible = "mediatek,mt8173-mdp-wrot";
+				reg = <0 0x14007000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_WROT0>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+				iommus = <&iommu M4U_PORT_MDP_WROT0>;
+				mediatek,larb = <&larb0>;
+			};
+
+			mdp_wrot1: wrot at 14008000 {
+				compatible = "mediatek,mt8173-mdp-wrot";
+				reg = <0 0x14008000 0 0x1000>;
+				clocks = <&mmsys CLK_MM_MDP_WROT1>;
+				power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+				iommus = <&iommu M4U_PORT_MDP_WROT1>;
+				mediatek,larb = <&larb4>;
+			};
+		};
+
 		ovl0: ovl at 1400c000 {
 			compatible = "mediatek,mt8173-disp-ovl";
 			reg = <0 0x1400c000 0 0x1000>;
-- 
1.7.9.5
