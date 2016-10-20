From: jamesjj.liao@mediatek.com (James Liao)
Date: Thu, 20 Oct 2016 16:56:37 +0800
Subject: [PATCH v9 3/4] soc: mediatek: Add MT2701 power dt-bindings
In-Reply-To: <1476953798-23263-1-git-send-email-jamesjj.liao@mediatek.com>
References: <1476953798-23263-1-git-send-email-jamesjj.liao@mediatek.com>
Message-ID: <1476953798-23263-4-git-send-email-jamesjj.liao@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shunli Wang <shunli.wang@mediatek.com>

Add power dt-bindings for MT2701.

Signed-off-by: Shunli Wang <shunli.wang@mediatek.com>
Signed-off-by: James Liao <jamesjj.liao@mediatek.com>
Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Kevin Hilman <khilman@baylibre.com>
---
 .../devicetree/bindings/soc/mediatek/scpsys.txt    | 13 +++++++----
 include/dt-bindings/power/mt2701-power.h           | 27 ++++++++++++++++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)
 create mode 100644 include/dt-bindings/power/mt2701-power.h

diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index e8f15e3..16fe94d 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -9,17 +9,20 @@ domain control.
 
 The driver implements the Generic PM domain bindings described in
 power/power_domain.txt. It provides the power domains defined in
-include/dt-bindings/power/mt8173-power.h.
+include/dt-bindings/power/mt8173-power.h and mt2701-power.h.
 
 Required properties:
-- compatible: Must be "mediatek,mt8173-scpsys"
+- compatible: Should be one of:
+	- "mediatek,mt2701-scpsys"
+	- "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
 - infracfg: must contain a phandle to the infracfg controller
 - clock, clock-names: clocks according to the common clock binding.
-                      The clocks needed "mm", "mfg", "venc" and "venc_lt".
-		      These are the clocks which hardware needs to be enabled
-		      before enabling certain power domains.
+                      These are clocks which hardware needs to be
+                      enabled before enabling certain power domains.
+	Required clocks for MT2701: "mm", "mfg", "ethif"
+	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
 Optional properties:
 - vdec-supply: Power supply for the vdec power domain
diff --git a/include/dt-bindings/power/mt2701-power.h b/include/dt-bindings/power/mt2701-power.h
new file mode 100644
index 0000000..64cc826
--- /dev/null
+++ b/include/dt-bindings/power/mt2701-power.h
@@ -0,0 +1,27 @@
+/*
+ * Copyright (C) 2015 MediaTek Inc.
+ *
+ * This program is free software: you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_POWER_MT2701_POWER_H
+#define _DT_BINDINGS_POWER_MT2701_POWER_H
+
+#define MT2701_POWER_DOMAIN_CONN	0
+#define MT2701_POWER_DOMAIN_DISP	1
+#define MT2701_POWER_DOMAIN_MFG		2
+#define MT2701_POWER_DOMAIN_VDEC	3
+#define MT2701_POWER_DOMAIN_ISP		4
+#define MT2701_POWER_DOMAIN_BDP		5
+#define MT2701_POWER_DOMAIN_ETH		6
+#define MT2701_POWER_DOMAIN_HIF		7
+#define MT2701_POWER_DOMAIN_IFR_MSC	8
+
+#endif /* _DT_BINDINGS_POWER_MT2701_POWER_H */
-- 
1.9.1
