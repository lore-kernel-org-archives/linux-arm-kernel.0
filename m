From: rick.chang@mediatek.com (Rick Chang)
Date: Tue, 22 Nov 2016 11:46:16 +0800
Subject: [PATCH v7 3/4] arm: dts: mt2701: Add node for Mediatek JPEG Decoder
In-Reply-To: <1479786377-11567-1-git-send-email-rick.chang@mediatek.com>
References: <1479786377-11567-1-git-send-email-rick.chang@mediatek.com>
Message-ID: <1479786377-11567-4-git-send-email-rick.chang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Rick Chang <rick.chang@mediatek.com>
Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
---
This patch depends on: 
  CCF "Add clock support for Mediatek MT2701"[1]
  iommu and smi "Add the dtsi node of iommu and smi for mt2701"[2]

[1] http://lists.infradead.org/pipermail/linux-mediatek/2016-October/007271.html
[2] https://patchwork.kernel.org/patch/9164013/
---
 arch/arm/boot/dts/mt2701.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/mt2701.dtsi b/arch/arm/boot/dts/mt2701.dtsi
index 8f13c70..4dd5048 100644
--- a/arch/arm/boot/dts/mt2701.dtsi
+++ b/arch/arm/boot/dts/mt2701.dtsi
@@ -298,6 +298,20 @@
 		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
 	};
 
+	jpegdec: jpegdec at 15004000 {
+		compatible = "mediatek,mt2701-jpgdec";
+		reg = <0 0x15004000 0 0x1000>;
+		interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_LOW>;
+		clocks =  <&imgsys CLK_IMG_JPGDEC_SMI>,
+			  <&imgsys CLK_IMG_JPGDEC>;
+		clock-names = "jpgdec-smi",
+			      "jpgdec";
+		power-domains = <&scpsys MT2701_POWER_DOMAIN_ISP>;
+		mediatek,larb = <&larb2>;
+		iommus = <&iommu MT2701_M4U_PORT_JPGDEC_WDMA>,
+			 <&iommu MT2701_M4U_PORT_JPGDEC_BSDMA>;
+	};
+
 	vdecsys: syscon at 16000000 {
 		compatible = "mediatek,mt2701-vdecsys", "syscon";
 		reg = <0 0x16000000 0 0x1000>;
-- 
1.9.1
