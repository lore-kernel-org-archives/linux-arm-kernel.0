From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 15 May 2014 20:31:56 +0900
Subject: [PATCH v6 01/17] ARM: shmobile: r8a7779: Add clock index macros for
 DT sources
In-Reply-To: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
References: <1400153532-23675-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400153532-23675-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add macros usable by device tree sources to reference r8a7779 clocks by
index.

Based on work for the r8a7791 SoC by Laurent Pinchart.

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
v5
* No Change

v4
* Add R8A7779_CLK_B

v3
* As suggested by Laurent Pinchart
  - Consolidate R8A7779_CLK_HSPI{0,1,2} into R8A7779_CLK_HSPI
  - Correct inverted indexes of R8A7779_CLK_TMU{1,2}
  - Consolidate R8A7779_CLK_{E,O}HCI{0,1} into R8A7779_CLK_USB{0,1}
  - Add ethernet, MMC and HSCIF entries
  - Replace R8A7779_SCIF6 with R8A7779_CLK_SCIF5

* Add R8A7779_CLK_PCIE

v2
* No change
---
 include/dt-bindings/clock/r8a7779-clock.h | 64 +++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 include/dt-bindings/clock/r8a7779-clock.h

diff --git a/include/dt-bindings/clock/r8a7779-clock.h b/include/dt-bindings/clock/r8a7779-clock.h
new file mode 100644
index 0000000..381a611
--- /dev/null
+++ b/include/dt-bindings/clock/r8a7779-clock.h
@@ -0,0 +1,64 @@
+/*
+ * Copyright (C) 2013  Horms Solutions Ltd.
+ *
+ * Contact: Simon Horman <horms@verge.net.au>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#ifndef __DT_BINDINGS_CLOCK_R8A7779_H__
+#define __DT_BINDINGS_CLOCK_R8A7779_H__
+
+/* CPG */
+#define R8A7779_CLK_PLLA	0
+#define R8A7779_CLK_Z		1
+#define R8A7779_CLK_ZS		2
+#define R8A7779_CLK_S		3
+#define R8A7779_CLK_S1		4
+#define R8A7779_CLK_P		5
+#define R8A7779_CLK_B		6
+#define R8A7779_CLK_OUT		7
+
+/* MSTP 0 */
+#define R8A7779_CLK_HSPI	7
+#define R8A7779_CLK_TMU2	14
+#define R8A7779_CLK_TMU1	15
+#define R8A7779_CLK_TMU0	16
+#define R8A7779_CLK_HSCIF1	18
+#define R8A7779_CLK_HSCIF0	19
+#define R8A7779_CLK_SCIF5	21
+#define R8A7779_CLK_SCIF4	22
+#define R8A7779_CLK_SCIF3	23
+#define R8A7779_CLK_SCIF2	24
+#define R8A7779_CLK_SCIF1	25
+#define R8A7779_CLK_SCIF0	26
+#define R8A7779_CLK_I2C3	27
+#define R8A7779_CLK_I2C2	28
+#define R8A7779_CLK_I2C1	29
+#define R8A7779_CLK_I2C0	30
+
+/* MSTP 1 */
+#define R8A7779_CLK_USB01	0
+#define R8A7779_CLK_USB2	1
+#define R8A7779_CLK_DU		3
+#define R8A7779_CLK_VIN2	8
+#define R8A7779_CLK_VIN1	9
+#define R8A7779_CLK_VIN0	10
+#define R8A7779_CLK_ETHER	14
+#define R8A7779_CLK_SATA	15
+#define R8A7779_CLK_PCIE	16
+#define R8A7779_CLK_VIN3	20
+
+/* MSTP 3 */
+#define R8A7779_CLK_SDHI3	20
+#define R8A7779_CLK_SDHI2	21
+#define R8A7779_CLK_SDHI1	22
+#define R8A7779_CLK_SDHI0	23
+#define R8A7779_CLK_MMC1	30
+#define R8A7779_CLK_MMC0	31
+
+
+#endif /* __DT_BINDINGS_CLOCK_R8A7779_H__ */
-- 
1.8.5.2
