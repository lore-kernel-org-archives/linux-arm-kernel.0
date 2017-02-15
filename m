From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 15 Feb 2017 15:50:13 -0600
Subject: [PATCH 2/5] dt-bindings: Add Arria10 System Resource reset manager
 offsets
In-Reply-To: <1487195416-23827-1-git-send-email-thor.thayer@linux.intel.com>
References: <1487195416-23827-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1487195416-23827-3-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The Arria10 System Resource reset manager handles the Arria10
peripheral PHYs. This patch adds the offsets for these PHYs.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
 MAINTAINERS                                    |  1 +
 include/dt-bindings/reset/altr,rst-mgr-a10sr.h | 31 ++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10sr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9daf28b..a2c74db 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -654,6 +654,7 @@ S:	Maintained
 F:	drivers/gpio/gpio-altera-a10sr.c
 F:	drivers/mfd/altera-a10sr.c
 F:	include/linux/mfd/altera-a10sr.h
+F:	include/dt-bindings/reset/altr,rst-mgr-a10sr.h
 
 ALTERA TRIPLE SPEED ETHERNET DRIVER
 M:	Vince Bridgers <vbridger@opensource.altera.com>
diff --git a/include/dt-bindings/reset/altr,rst-mgr-a10sr.h b/include/dt-bindings/reset/altr,rst-mgr-a10sr.h
new file mode 100644
index 0000000..252f71a7
--- /dev/null
+++ b/include/dt-bindings/reset/altr,rst-mgr-a10sr.h
@@ -0,0 +1,31 @@
+/*
+ *  Copyright Intel Corporation (C) 2017. All Rights Reserved
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program.  If not, see <http://www.gnu.org/licenses/>.
+ *
+ * Reset binding definitions for Altera Arria10 MAX5 System Resource Chip
+ *
+ * Adapted from altr,rst-mgr-a10.h
+ */
+
+#ifndef _DT_BINDINGS_RESET_ALTR_RST_MGR_A10SR_H
+#define _DT_BINDINGS_RESET_ALTR_RST_MGR_A10SR_H
+
+/* Peripheral PHY resets */
+#define A10SR_RESET_ENET_HPS	0
+#define A10SR_RESET_PCIE	1
+#define A10SR_RESET_FILE	2
+#define A10SR_RESET_BQSPI	3
+#define A10SR_RESET_USB		4
+
+#endif
-- 
1.9.1
