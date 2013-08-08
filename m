From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Thu,  8 Aug 2013 08:15:04 +0200
Subject: [PATCH v3 10/19] ARM: at91/dt: add system clk id definitions in
 dt-bindings include dir
In-Reply-To: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
References: <1375937608-3773-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1375942504-9010-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds system clk ids definitions into dt-bindinds include dir
(include/dt-bindings/clk/at91/'soc-name'/system-clk.h).

These definitions will be used by dt definition to define and reference
system clks.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 .../dt-bindings/clk/at91/at91rm9200/clk-system.h   |   16 +++++++++++++++
 .../dt-bindings/clk/at91/at91sam9261/clk-system.h  |   15 ++++++++++++++
 include/dt-bindings/clk/at91/common/clk-system.h   |   21 ++++++++++++++++++++
 3 files changed, 52 insertions(+)
 create mode 100644 include/dt-bindings/clk/at91/at91rm9200/clk-system.h
 create mode 100644 include/dt-bindings/clk/at91/at91sam9261/clk-system.h
 create mode 100644 include/dt-bindings/clk/at91/common/clk-system.h

diff --git a/include/dt-bindings/clk/at91/at91rm9200/clk-system.h b/include/dt-bindings/clk/at91/at91rm9200/clk-system.h
new file mode 100644
index 0000000..43bccd5
--- /dev/null
+++ b/include/dt-bindings/clk/at91/at91rm9200/clk-system.h
@@ -0,0 +1,16 @@
+/*
+ * This header provides constants for AT91RM9200 system clocks.
+ *
+ * The constants defined in this header are being used in dts.
+ */
+
+#ifndef _DT_BINDINGS_CLK_AT91RM9200_SYSTEM_H
+#define _DT_BINDINGS_CLK_AT91RM9200_SYSTEM_H
+
+#include <dt-bindings/clk/at91/common/system-clk.h>
+
+#define AT91RM9200_UDP_SYS_CLK		1
+#define AT91RM9200_MCKUDP_SYS_CLK	2
+#define AT91RM9200_UHP_SYS_CLK		4
+
+#endif
diff --git a/include/dt-bindings/clk/at91/at91sam9261/clk-system.h b/include/dt-bindings/clk/at91/at91sam9261/clk-system.h
new file mode 100644
index 0000000..28a140a
--- /dev/null
+++ b/include/dt-bindings/clk/at91/at91sam9261/clk-system.h
@@ -0,0 +1,15 @@
+/*
+ * This header provides constants for AT91SAM9261 system clocks.
+ *
+ * The constants defined in this header are being used in dts.
+ */
+
+#ifndef _DT_BINDINGS_CLK_AT91SAM9261_SYSTEM_H
+#define _DT_BINDINGS_CLK_AT91SAM9261_SYSTEM_H
+
+#include <dt-bindings/clk/at91/common/system-clk.h>
+
+#define AT91SAM9261_HCK0_SYS_CLK	16
+#define AT91SAM9261_HCK1_SYS_CLK	17
+
+#endif
diff --git a/include/dt-bindings/clk/at91/common/clk-system.h b/include/dt-bindings/clk/at91/common/clk-system.h
new file mode 100644
index 0000000..c0fb124
--- /dev/null
+++ b/include/dt-bindings/clk/at91/common/clk-system.h
@@ -0,0 +1,21 @@
+/*
+ * This header provides constants for AT91 system clocks.
+ *
+ * The constants defined in this header are being used in dts.
+ */
+
+#ifndef _DT_BINDINGS_CLK_AT91_SYSTEM_H
+#define _DT_BINDINGS_CLK_AT91_SYSTEM_H
+
+#define AT91_PCK_SYS_CLK	0
+#define AT91_DDRCK_SYS_CLK	2
+#define AT91_LCDCK_SYS_CLK	3
+#define AT91_SMDCK_SYS_CLK	4
+#define AT91_UHP_SYS_CLK	6
+#define AT91_UDP_SYS_CLK	7
+
+#define AT91_PROG_SYS_CLK(id)	(8 + id)
+
+#define AT91_MAX_SYS_CLKS	32
+
+#endif
-- 
1.7.9.5
