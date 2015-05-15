From: yong.wu@mediatek.com (Yong Wu)
Date: Fri, 15 May 2015 17:43:25 +0800
Subject: [PATCH v2 2/6] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
References: <1431683009-18158-1-git-send-email-yong.wu@mediatek.com>
Message-ID: <1431683009-18158-3-git-send-email-yong.wu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add smi binding document.

Signed-off-by: Yong Wu <yong.wu@mediatek.com>
---
 .../bindings/soc/mediatek/mediatek,smi-larb.txt    | 24 ++++++++++++++++++++++
 .../bindings/soc/mediatek/mediatek,smi.txt         | 22 ++++++++++++++++++++
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
new file mode 100644
index 0000000..c06c5b6
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi-larb.txt
@@ -0,0 +1,24 @@
+SMI(Smart Multimedia Interface) Local Arbiter
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi-larb"
+- reg : the register and size of each local arbiter.
+- smi : must be "&smi_common". Refer to bindings/soc/mediatek,smi.txt.
+- clocks : must contain one entry for each clock-names.
+	There are 2 clockes:
+	APB clock : Advanced Peripheral Bus clock, It's the clock for setting
+		the register.
+	SMI clock : It's the clock for transfer data and command.
+- clock-name: must be "apb" and "smi".
+
+Example:
+	larb0:larb at 14021000 {
+		compatible = "mediatek,mt8173-smi-larb";
+		reg = <0 0x14021000 0 0x1000>;
+		smi = <&smi_common>;
+		clocks = <&mmsys MM_SMI_LARB0>,
+			 <&mmsys MM_SMI_LARB0>;
+		clock-names = "apb", "smi";
+	};
diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
new file mode 100644
index 0000000..c2389b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
@@ -0,0 +1,22 @@
+SMI(Smart Multimedia Interface)
+
+The hardware block diagram please check bindings/iommu/mediatek,iommu.txt
+
+Required properties:
+- compatible : must be "mediatek,mt8173-smi"
+- reg : the register and size of the smi.
+- clocks : must contain one entry for each clock-names.
+	There are 2 clockes:
+	APB clock : Advanced Peripheral Bus clock, It's the clock for setting
+		the register.
+	SMI clock : It's the clock for transfer data and command.
+- clock-name: must be "apb" and "smi".
+
+Example:
+	smi_common:smi at 14022000 {
+		compatible = "mediatek,mt8173-smi";
+		reg = <0 0x14022000 0 0x1000>;
+		clocks = <&mmsys MM_SMI_COMMON>,
+			 <&mmsys MM_SMI_COMMON>;
+		clock-names = "apb", "smi";
+	};
-- 
1.8.1.1.dirty
