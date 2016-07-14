From: minghsiu.tsai@mediatek.com (Minghsiu Tsai)
Date: Thu, 14 Jul 2016 20:18:01 +0800
Subject: [PATCH 4/4] arm64: dts: mediatek: Add MDP for MT8173
In-Reply-To: <1468498681-19955-1-git-send-email-minghsiu.tsai@mediatek.com>
References: <1468498681-19955-1-git-send-email-minghsiu.tsai@mediatek.com>
Message-ID: <1468498681-19955-5-git-send-email-minghsiu.tsai@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MDP node for MT8173

Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   80 ++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 77b8c4e..8e1b85d 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -26,6 +26,16 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		mdp_rdma0 = &mdp_rdma0;
+		mdp_rdma1 = &mdp_rdma1;
+		mdp_rsz0 = &mdp_rsz0;
+		mdp_rsz1 = &mdp_rsz1;
+		mdp_rsz2 = &mdp_rsz2;
+		mdp_wdma0 = &mdp_wdma0;
+		mdp_wrot0 = &mdp_wrot0;
+		mdp_wrot1 = &mdp_wrot1;
+	};
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -678,6 +688,76 @@
 			#clock-cells = <1>;
 		};
 
+		mdp_rdma0: rdma at 14001000 {
+			compatible = "mediatek,mt8173-mdp-rdma",
+				     "mediatek,mt8173-mdp";
+			reg = <0 0x14001000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RDMA0>,
+				 <&mmsys CLK_MM_MUTEX_32K>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_RDMA0>;
+			mediatek,larb = <&larb0>;
+			mediatek,vpu = <&vpu>;
+		};
+
+		mdp_rdma1: rdma at 14002000 {
+			compatible = "mediatek,mt8173-mdp-rdma";
+			reg = <0 0x14002000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RDMA1>,
+				 <&mmsys CLK_MM_MUTEX_32K>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_RDMA1>;
+			mediatek,larb = <&larb4>;
+		};
+
+		mdp_rsz0: rsz at 14003000 {
+			compatible = "mediatek,mt8173-mdp-rsz";
+			reg = <0 0x14003000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ0>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		};
+
+		mdp_rsz1: rsz at 14004000 {
+			compatible = "mediatek,mt8173-mdp-rsz";
+			reg = <0 0x14004000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ1>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		};
+
+		mdp_rsz2: rsz at 14005000 {
+			compatible = "mediatek,mt8173-mdp-rsz";
+			reg = <0 0x14005000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_RSZ2>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		};
+
+		mdp_wdma0: wdma at 14006000 {
+			compatible = "mediatek,mt8173-mdp-wdma";
+			reg = <0 0x14006000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_WDMA>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_WDMA>;
+			mediatek,larb = <&larb0>;
+		};
+
+		mdp_wrot0: wrot at 14007000 {
+			compatible = "mediatek,mt8173-mdp-wrot";
+			reg = <0 0x14007000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_WROT0>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_WROT0>;
+			mediatek,larb = <&larb0>;
+		};
+
+		mdp_wrot1: wrot at 14008000 {
+			compatible = "mediatek,mt8173-mdp-wrot";
+			reg = <0 0x14008000 0 0x1000>;
+			clocks = <&mmsys CLK_MM_MDP_WROT1>;
+			power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+			iommus = <&iommu M4U_PORT_MDP_WROT1>;
+			mediatek,larb = <&larb4>;
+		};
+
 		pwm0: pwm at 1401e000 {
 			compatible = "mediatek,mt8173-disp-pwm",
 				     "mediatek,mt6595-disp-pwm";
-- 
1.7.9.5
