From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Tue, 6 Nov 2018 14:42:05 +0800
Subject: [PATCH v1 10/11] dt-bindings: soc: Add MT8183 power dt-bindings
In-Reply-To: <20181106064206.17535-1-weiyi.lu@mediatek.com>
References: <20181106064206.17535-1-weiyi.lu@mediatek.com>
Message-ID: <20181106064206.17535-12-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power dt-bindings for MT8183.

Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 .../bindings/soc/mediatek/scpsys.txt          | 14 ++++++++++
 include/dt-bindings/power/mt8183-power.h      | 26 +++++++++++++++++++
 2 files changed, 40 insertions(+)
 create mode 100644 include/dt-bindings/power/mt8183-power.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index d6fe16f094af..b4728ce81c43 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -14,6 +14,7 @@ power/power_domain.txt. It provides the power domains defined in
 - include/dt-bindings/power/mt2701-power.h
 - include/dt-bindings/power/mt2712-power.h
 - include/dt-bindings/power/mt7622-power.h
+- include/dt-bindings/power/mt8183-power.h
 
 Required properties:
 - compatible: Should be one of:
@@ -24,18 +25,31 @@ Required properties:
 	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
 	- "mediatek,mt7623a-scpsys": For MT7623A SoC
 	- "mediatek,mt8173-scpsys"
+	- "mediatek,mt8183-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
 - infracfg: must contain a phandle to the infracfg controller
 - clock, clock-names: clocks according to the common clock binding.
                       These are clocks which hardware needs to be
                       enabled before enabling certain power domains.
+                      The new clock type "BASIC" belongs to the type above.
+                      As to the new clock type "SUBSYS" needs to be
+                      enabled before releasing bus protection.
 	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622: "hif_sel"
 	Required clocks for MT7622A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
+	Required clocks for MT8183: BASIC: "audio", "mfg", "mm", "cam", "isp",
+					   "vpu", "vpu1", "vpu2", "vpu3"
+				    SUBSYS: "mm-0", "mm-1", "mm-2", "mm-3",
+					    "mm-4", "mm-5", "mm-6", "mm-7",
+					    "mm-8", "mm-9", "isp-0", "isp-1",
+					    "cam-0", "cam-1", "cam-2", "cam-3",
+					    "cam-4", "cam-5", "cam-6", "vpu-0",
+					    "vpu-1", "vpu-2", "vpu-3", "vpu-4",
+					    "vpu-5"
 
 Optional properties:
 - vdec-supply: Power supply for the vdec power domain
diff --git a/include/dt-bindings/power/mt8183-power.h b/include/dt-bindings/power/mt8183-power.h
new file mode 100644
index 000000000000..5c0c8c7e3cd0
--- /dev/null
+++ b/include/dt-bindings/power/mt8183-power.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (c) 2018 MediaTek Inc.
+ * Author: Weiyi Lu <weiyi.lu@mediatek.com>
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT8183_POWER_H
+#define _DT_BINDINGS_POWER_MT8183_POWER_H
+
+#define MT8183_POWER_DOMAIN_AUDIO	0
+#define MT8183_POWER_DOMAIN_CONN	1
+#define MT8183_POWER_DOMAIN_MFG_ASYNC	2
+#define MT8183_POWER_DOMAIN_MFG		3
+#define MT8183_POWER_DOMAIN_MFG_CORE0	4
+#define MT8183_POWER_DOMAIN_MFG_CORE1	5
+#define MT8183_POWER_DOMAIN_MFG_2D	6
+#define MT8183_POWER_DOMAIN_DISP	7
+#define MT8183_POWER_DOMAIN_CAM		8
+#define MT8183_POWER_DOMAIN_ISP		9
+#define MT8183_POWER_DOMAIN_VDEC	10
+#define MT8183_POWER_DOMAIN_VENC	11
+#define MT8183_POWER_DOMAIN_VPU_TOP	12
+#define MT8183_POWER_DOMAIN_VPU_CORE0	13
+#define MT8183_POWER_DOMAIN_VPU_CORE1	14
+
+#endif /* _DT_BINDINGS_POWER_MT8183_POWER_H */
-- 
2.18.0
