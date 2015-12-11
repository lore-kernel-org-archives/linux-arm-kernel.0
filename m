From: tiffany.lin@mediatek.com (Tiffany Lin)
Date: Fri, 11 Dec 2015 17:55:37 +0800
Subject: [PATCH v2 2/8] arm64: dts: mediatek: Add node for Mediatek Video
 Processor Unit
In-Reply-To: <1449827743-22895-1-git-send-email-tiffany.lin@mediatek.com>
References: <1449827743-22895-1-git-send-email-tiffany.lin@mediatek.com>
Message-ID: <1449827743-22895-3-git-send-email-tiffany.lin@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add VPU drivers for MT8173

Signed-off-by: Andrew-CT Chen <andrew-ct.chen@mediatek.com>
Signed-off-by: Tiffany Lin <tiffany.lin@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 4dd5f93..b8c8ff0 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -258,6 +258,17 @@
 			clock-names = "spi", "wrap";
 		};
 
+		vpu: vpu at 10020000 {
+			compatible = "mediatek,mt8173-vpu";
+			reg = <0 0x10020000 0 0x30000>,
+			      <0 0x10050000 0 0x100>;
+			reg-names = "tcm", "cfg_reg";
+			interrupts = <GIC_SPI 166 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&topckgen CLK_TOP_SCP_SEL>;
+			clock-names = "main";
+			iommus = <&iommu M4U_LARB3_ID M4U_PORT_VENC_RCPU>;
+		};
+
 		sysirq: intpol-controller at 10200620 {
 			compatible = "mediatek,mt8173-sysirq",
 				     "mediatek,mt6577-sysirq";
-- 
1.7.9.5
