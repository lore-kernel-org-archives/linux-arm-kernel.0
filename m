From: hs.liao@mediatek.com (hs.liao at mediatek.com)
Date: Wed, 20 Jan 2016 13:14:38 +0800
Subject: [RFC 1/3] dt-bindings: soc: Add documentation for the MediaTek GCE
 unit
In-Reply-To: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
References: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
Message-ID: <1453266881-16849-2-git-send-email-hs.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: HS Liao <hs.liao@mediatek.com>

This adds documentation for the MediaTek Global Command Engine (GCE) unit
found in MT8173 SoCs.

Signed-off-by: HS Liao <hs.liao@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/gce.txt       |   33 ++++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/gce.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/gce.txt b/Documentation/devicetree/bindings/soc/mediatek/gce.txt
new file mode 100644
index 0000000..878b11e
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/gce.txt
@@ -0,0 +1,33 @@
+MediaTek GCE
+===============
+
+The Global Command Engine (GCE) is used to help read/write registers with
+critical time limitation, such as updating display configuration during the
+vblank. The GCE can be used to implement the Command Queue (CMDQ) driver.
+Currently, the GCE only supports display related hardwares, but we expect
+it can be extended to other hardwares for future requirements.
+
+Required properties:
+- compatible: Must be "mediatek,mt8173-gce"
+- reg: Address range of the GCE unit
+- interrupts: The interrupt signal from the GCE block
+- clock: Clocks according to the common clock binding
+- clock-names: Must be "gce" to stand for GCE clock
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
+	mmsys: clock-controller at 14000000 {
+		compatible = "mediatek,mt8173-mmsys", "syscon";
+		reg = <0 0x14000000 0 0x1000>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		#clock-cells = <1>;
+		mediatek,gce = <&gce>;
+	};
-- 
1.7.9.5
