From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Fri, 24 Aug 2012 13:26:03 +0200
Subject: [PATCH 2/4] clk: ux500: First version of clock definitions for ux500
In-Reply-To: <1345807565-7729-1-git-send-email-ulf.hansson@stericsson.com>
References: <1345807565-7729-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1345807565-7729-3-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

In this first version of the clock definitions, the structure for
ux500 are set. Support for u8500, u9540 and u8540 are prepared.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/clk/ux500/Makefile              |    5 +++++
 drivers/clk/ux500/u8500_clk.c           |   21 +++++++++++++++++++++
 drivers/clk/ux500/u8540_clk.c           |   21 +++++++++++++++++++++
 drivers/clk/ux500/u9540_clk.c           |   21 +++++++++++++++++++++
 include/linux/platform_data/clk-ux500.h |   17 +++++++++++++++++
 5 files changed, 85 insertions(+)
 create mode 100644 drivers/clk/ux500/u8500_clk.c
 create mode 100644 drivers/clk/ux500/u8540_clk.c
 create mode 100644 drivers/clk/ux500/u9540_clk.c
 create mode 100644 include/linux/platform_data/clk-ux500.h

diff --git a/drivers/clk/ux500/Makefile b/drivers/clk/ux500/Makefile
index a3ccd1b..858fbfe 100644
--- a/drivers/clk/ux500/Makefile
+++ b/drivers/clk/ux500/Makefile
@@ -5,3 +5,8 @@
 # Clock types
 obj-y += clk-prcc.o
 obj-y += clk-prcmu.o
+
+# Clock definitions
+obj-y += u8500_clk.o
+obj-y += u9540_clk.o
+obj-y += u8540_clk.o
diff --git a/drivers/clk/ux500/u8500_clk.c b/drivers/clk/ux500/u8500_clk.c
new file mode 100644
index 0000000..2bc4901
--- /dev/null
+++ b/drivers/clk/ux500/u8500_clk.c
@@ -0,0 +1,21 @@
+/*
+ * Clock definitions for u8500 platform.
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/platform_data/clk-ux500.h>
+
+#include "clk.h"
+
+void u8500_clk_init(void)
+{
+	/* register clocks here */
+}
diff --git a/drivers/clk/ux500/u8540_clk.c b/drivers/clk/ux500/u8540_clk.c
new file mode 100644
index 0000000..10adfd2
--- /dev/null
+++ b/drivers/clk/ux500/u8540_clk.c
@@ -0,0 +1,21 @@
+/*
+ * Clock definitions for u8540 platform.
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/platform_data/clk-ux500.h>
+
+#include "clk.h"
+
+void u8540_clk_init(void)
+{
+	/* register clocks here */
+}
diff --git a/drivers/clk/ux500/u9540_clk.c b/drivers/clk/ux500/u9540_clk.c
new file mode 100644
index 0000000..dbc0191
--- /dev/null
+++ b/drivers/clk/ux500/u9540_clk.c
@@ -0,0 +1,21 @@
+/*
+ * Clock definitions for u9540 platform.
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/clk-provider.h>
+#include <linux/mfd/dbx500-prcmu.h>
+#include <linux/platform_data/clk-ux500.h>
+
+#include "clk.h"
+
+void u9540_clk_init(void)
+{
+	/* register clocks here */
+}
diff --git a/include/linux/platform_data/clk-ux500.h b/include/linux/platform_data/clk-ux500.h
new file mode 100644
index 0000000..3af0da1
--- /dev/null
+++ b/include/linux/platform_data/clk-ux500.h
@@ -0,0 +1,17 @@
+/*
+ * Clock definitions for ux500 platforms
+ *
+ * Copyright (C) 2012 ST-Ericsson SA
+ * Author: Ulf Hansson <ulf.hansson@linaro.org>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ */
+
+#ifndef __CLK_UX500_H
+#define __CLK_UX500_H
+
+void u8500_clk_init(void);
+void u9540_clk_init(void);
+void u8540_clk_init(void);
+
+#endif /* __CLK_UX500_H */
-- 
1.7.10
