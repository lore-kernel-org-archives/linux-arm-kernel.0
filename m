From: rick.chang@mediatek.com (Rick Chang)
Date: Tue, 22 Nov 2016 11:46:14 +0800
Subject: [PATCH v7 1/4] dt-bindings: mediatek: Add a binding for Mediatek JPEG
 Decoder
In-Reply-To: <1479786377-11567-1-git-send-email-rick.chang@mediatek.com>
References: <1479786377-11567-1-git-send-email-rick.chang@mediatek.com>
Message-ID: <1479786377-11567-2-git-send-email-rick.chang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a DT binding documentation for Mediatek JPEG Decoder of
MT2701 SoC.

Signed-off-by: Rick Chang <rick.chang@mediatek.com>
Signed-off-by: Minghsiu Tsai <minghsiu.tsai@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 .../bindings/media/mediatek-jpeg-decoder.txt       | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt

diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
new file mode 100644
index 0000000..3813947
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-decoder.txt
@@ -0,0 +1,37 @@
+* Mediatek JPEG Decoder
+
+Mediatek JPEG Decoder is the JPEG decode hardware present in Mediatek SoCs
+
+Required properties:
+- compatible : must be one of the following string:
+	"mediatek,mt8173-jpgdec"
+	"mediatek,mt2701-jpgdec"
+- reg : physical base address of the jpeg decoder registers and length of
+  memory mapped region.
+- interrupts : interrupt number to the interrupt controller.
+- clocks: device clocks, see
+  Documentation/devicetree/bindings/clock/clock-bindings.txt for details.
+- clock-names: must contain "jpgdec-smi" and "jpgdec".
+- power-domains: a phandle to the power domain, see
+  Documentation/devicetree/bindings/power/power_domain.txt for details.
+- mediatek,larb: must contain the local arbiters in the current Socs, see
+  Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
+  for details.
+- iommus: should point to the respective IOMMU block with master port as
+  argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
+  for details.
+
+Example:
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
-- 
1.9.1
