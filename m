From: hs.liao@mediatek.com (HS Liao)
Date: Tue, 1 Mar 2016 21:29:14 +0800
Subject: [RFC v2 1/3] dt-bindings: soc: Add documentation for the MediaTek GCE
 unit
In-Reply-To: <1456838956-16153-1-git-send-email-hs.liao@mediatek.com>
References: <1456838956-16153-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1456838956-16153-2-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds documentation for the MediaTek Global Command Engine (GCE) unit
found in MT8173 SoCs.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/gce.txt       |   34 ++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/gce.txt b/Documentation/devicetree/bindings/soc/mediatek/gce.txt
new file mode 100644
index 0000000..eff07e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/gce.txt
@@ -0,0 +1,34 @@
+MediaTek GCE
+===============
+
+The Global Command Engine (GCE) is used to help read/write registers with
+critical time limitation, such as updating display configuration during the
+vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
+
+Required properties:
+- compatible: Must be "mediatek,mt8173-gce"
+- reg: Address range of the GCE unit
+- interrupts: The interrupt signal from the GCE block
+- clock: Clocks according to the common clock binding
+- clock-names: Must be "gce" to stand for GCE clock
+
+Required properties for a client device:
+- mediatek,gce: Should point to the respective GCE block
+
+Example:
+
+	gce: gce at 10212000 {
+		compatible = "mediatek,mt8173-gce";
+		reg = <0 0x10212000 0 0x1000>;
+		interrupts = <GIC_SPI 135 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_INFRA_GCE>;
+		clock-names = "gce";
+	};
+
+Example for a client device:
+
+	mmsys: clock-controller at 14000000 {
+		compatible = "mediatek,mt8173-mmsys";
+		mediatek,gce = <&gce>;
+		...
+	};
-- 
1.7.9.5
