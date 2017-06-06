From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue,  6 Jun 2017 02:54:20 +0200
Subject: [PATCH v4 22/28] dt-bindings: power: Add Owl SPS power domains
In-Reply-To: <20170606005426.26446-1-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
Message-ID: <20170606005426.26446-23-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define power domains for all non-reserved S500 power gates.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3 -> v4: Unchanged
 
 v3: new
 
 .../devicetree/bindings/power/actions,owl-sps.txt     | 17 +++++++++++++++++
 include/dt-bindings/power/s500-powergate.h            | 19 +++++++++++++++++++
 2 files changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/actions,owl-sps.txt
 create mode 100644 include/dt-bindings/power/s500-powergate.h

diff --git a/Documentation/devicetree/bindings/power/actions,owl-sps.txt b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
new file mode 100644
index 000000000000..c5eed06c771e
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/actions,owl-sps.txt
@@ -0,0 +1,17 @@
+Actions Semi Owl Smart Power System (SPS)
+
+Required properties:
+- compatible          :  "actions,s500-sps" for S500
+- reg                 :  Offset and length of the register set for the device.
+- #power-domain-cells :  Must be 1.
+                         See macros in:
+                          include/dt-bindings/power/s500-powergate.h for S500
+
+
+Example:
+
+		sps: power-controller at b01b0100 {
+			compatible = "actions,s500-sps";
+			reg = <0xb01b0100 0x100>;
+			#power-domain-cells = <1>;
+		};
diff --git a/include/dt-bindings/power/s500-powergate.h b/include/dt-bindings/power/s500-powergate.h
new file mode 100644
index 000000000000..ccc4ac37bc42
--- /dev/null
+++ b/include/dt-bindings/power/s500-powergate.h
@@ -0,0 +1,19 @@
+/*
+ * Copyright (c) 2017 Andreas F?rber
+ *
+ * SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+ */
+#ifndef DT_BINDINGS_POWER_S500_POWERGATE_H
+#define DT_BINDINGS_POWER_S500_POWERGATE_H
+
+#define S500_PD_VDE	0
+#define S500_PD_VCE_SI	1
+#define S500_PD_USB2_1	2
+#define S500_PD_CPU2	3
+#define S500_PD_CPU3	4
+#define S500_PD_DMA	5
+#define S500_PD_DS	6
+#define S500_PD_USB3	7
+#define S500_PD_USB2_0	8
+
+#endif
-- 
2.12.3
