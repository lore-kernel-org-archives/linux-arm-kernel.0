From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Tue, 12 Nov 2013 22:04:53 +0100
Subject: [PATCH v5 04/17] clk: at91: add PMC macro file for dt definitions
In-Reply-To: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
References: <1384289513-3068-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1384290293-3412-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds a new macro file for PMC macros.

This macro file includes the definitions of SR (status register) bit
offsets and will be use to reference PMC irqs.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 include/dt-bindings/clk/at91.h |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)
 create mode 100644 include/dt-bindings/clk/at91.h

diff --git a/include/dt-bindings/clk/at91.h b/include/dt-bindings/clk/at91.h
new file mode 100644
index 0000000..0b4cb99
--- /dev/null
+++ b/include/dt-bindings/clk/at91.h
@@ -0,0 +1,22 @@
+/*
+ * This header provides constants for AT91 pmc status.
+ *
+ * The constants defined in this header are being used in dts.
+ *
+ * Licensed under GPLv2 or later.
+ */
+
+#ifndef _DT_BINDINGS_CLK_AT91_H
+#define _DT_BINDINGS_CLK_AT91_H
+
+#define AT91_PMC_MOSCS		0		/* MOSCS Flag */
+#define AT91_PMC_LOCKA		1		/* PLLA Lock */
+#define AT91_PMC_LOCKB		2		/* PLLB Lock */
+#define AT91_PMC_MCKRDY		3		/* Master Clock */
+#define AT91_PMC_LOCKU		6		/* UPLL Lock */
+#define AT91_PMC_PCKRDY(id)	(8 + (id))	/* Programmable Clock */
+#define AT91_PMC_MOSCSELS	16		/* Main Oscillator Selection */
+#define AT91_PMC_MOSCRCS	17		/* Main On-Chip RC */
+#define AT91_PMC_CFDEV		18		/* Clock Failure Detector Event */
+
+#endif
-- 
1.7.9.5
