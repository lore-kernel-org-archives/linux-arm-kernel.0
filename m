From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 9 Oct 2015 10:23:04 +0800
Subject: [PATCH v5 2/6] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
References: <1444357388-30257-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1444357388-30257-3-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add smi binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../memory-controllers/mediatek,smi-larb.txt       | 25 ++++++++++++++++++++++
 .../bindings/memory-controllers/mediatek,smi.txt   | 24 +++++++++++++++++++++
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt

diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
new file mode 100644
index 0000000..55ff3b7
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
@@ -0,0 +1,25 @@
+SMI (Smart Multimedia Interface) Local Arbiter
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi-larb"
+- reg : the register and size of this local arbiter.
+- mediatek,smi : a phandle to the smi_common node.
+- power-domains : a phandle to the power domain of this local arbiter.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names: must contain 2 entries, as follows:
+  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
+	    the register.
+  - "smi" : It's the clock for transfer data and command.
+
+Example:
+	larb1: larb at 16010000 {
+		compatible = "mediatek,mt8173-smi-larb";
+		reg = <0 0x16010000 0 0x1000>;
+		mediatek,smi = <&smi_common>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_VDEC>;
+		clocks = <&vdecsys CLK_VDEC_CKEN>,
+			 <&vdecsys CLK_VDEC_LARB_CKEN>;
+		clock-names = "apb", "smi";
+	};
diff --git a/Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
new file mode 100644
index 0000000..f54e91c
--- /dev/null
+++ b/Documentation/devicetree/bindings/memory-controllers/mediatek,smi.txt
@@ -0,0 +1,24 @@
+SMI (Smart Multimedia Interface)
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi"
+- reg : the register and size of the SMI block.
+- power-domains : a phandle to the power domain of this local arbiter.
+- clocks : Must contain an entry for each entry in clock-names.
+- clock-names : must contain 2 entries, as follows:
+  - "apb" : Advanced Peripheral Bus clock, It's the clock for setting
+	    the register.
+  - "smi" : It's the clock for transfer data and command.
+  They may be the same if both source clock are the same.
+
+Example:
+	smi_common: smi at 14022000 {
+		compatible = "mediatek,mt8173-smi";
+		reg = <0 0x14022000 0 0x1000>;
+		power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
+		clocks = <&mmsys CLK_MM_SMI_COMMON>,
+			 <&mmsys CLK_MM_SMI_COMMON>;
+		clock-names = "apb", "smi";
+	};
-- 
1.8.1.1.dirty
