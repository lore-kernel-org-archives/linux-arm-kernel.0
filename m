From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Wed, 22 Feb 2017 11:10:16 -0600
Subject: [PATCHv2 2/5] dt-bindings: reset: a10sr: Add Arria10 SR Reset
 Controller offsets
In-Reply-To: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
References: <1487783419-10912-1-git-send-email-thor.thayer@linux.intel.com>
Message-ID: <1487783419-10912-3-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

The Arria10 System Resource Chip reset controller handles the
Arria10 peripheral PHYs. This patch adds the offsets for
these PHYs.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2  Add NUM_RESETs to altr,rst-mgr-a10sr.h for maximum count.
---
 MAINTAINERS                                    |  1 +
 include/dt-bindings/reset/altr,rst-mgr-a10sr.h | 33 ++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/reset/altr,rst-mgr-a10sr.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b9af886..4b714bd 100644
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
index 0000000..9855925
--- /dev/null
+++ b/include/dt-bindings/reset/altr,rst-mgr-a10sr.h
@@ -0,0 +1,33 @@
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
+#define A10SR_RESET_NUM		5
+
+#endif
-- 
1.9.1
