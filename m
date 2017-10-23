From: weiyi.lu@mediatek.com (Weiyi Lu)
Date: Mon, 23 Oct 2017 12:10:36 +0800
Subject: [PATCH v6 5/9] dt-bindings: soc: add MT2712 power dt-bindings
In-Reply-To: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
References: <1508731840-4231-1-git-send-email-weiyi.lu@mediatek.com>
Message-ID: <1508731840-4231-6-git-send-email-weiyi.lu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add power dt-bindings for MT2712.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  3 +++
 include/dt-bindings/power/mt2712-power.h           | 26 ++++++++++++++++++++++
 2 files changed, 29 insertions(+)
 create mode 100644 include/dt-bindings/power/mt2712-power.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index 40056f7..76bf45b 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -12,11 +12,13 @@ power/power_domain.txt. It provides the power domains defined in
 - include/dt-bindings/power/mt8173-power.h
 - include/dt-bindings/power/mt6797-power.h
 - include/dt-bindings/power/mt2701-power.h
+- include/dt-bindings/power/mt2712-power.h
 - include/dt-bindings/power/mt7622-power.h
 
 Required properties:
 - compatible: Should be one of:
 	- "mediatek,mt2701-scpsys"
+	- "mediatek,mt2712-scpsys"
 	- "mediatek,mt6797-scpsys"
 	- "mediatek,mt7622-scpsys"
 	- "mediatek,mt8173-scpsys"
@@ -27,6 +29,7 @@ Required properties:
                       These are clocks which hardware needs to be
                       enabled before enabling certain power domains.
 	Required clocks for MT2701: "mm", "mfg", "ethif"
+	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
 	Required clocks for MT7622: "hif_sel"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
diff --git a/include/dt-bindings/power/mt2712-power.h b/include/dt-bindings/power/mt2712-power.h
new file mode 100644
index 0000000..92b46d7
--- /dev/null
+++ b/include/dt-bindings/power/mt2712-power.h
@@ -0,0 +1,26 @@
+/*
+ * Copyright (C) 2017 MediaTek Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ * See http://www.gnu.org/licenses/gpl-2.0.html for more details.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT2712_POWER_H
+#define _DT_BINDINGS_POWER_MT2712_POWER_H
+
+#define MT2712_POWER_DOMAIN_MM		0
+#define MT2712_POWER_DOMAIN_VDEC	1
+#define MT2712_POWER_DOMAIN_VENC	2
+#define MT2712_POWER_DOMAIN_ISP		3
+#define MT2712_POWER_DOMAIN_AUDIO	4
+#define MT2712_POWER_DOMAIN_USB		5
+#define MT2712_POWER_DOMAIN_USB2	6
+#define MT2712_POWER_DOMAIN_MFG		7
+
+#endif /* _DT_BINDINGS_POWER_MT2712_POWER_H */
-- 
1.9.1
