From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 15 May 2013 16:03:03 +0200
Subject: [PATCH 3/5] ARM: at91: dt: add pinctrl pre-processor define
In-Reply-To: <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
References: <20130515135821.GG22508@game.jcrosoft.org>
 <1368626585-24425-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1368626585-24425-3-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 include/dt-bindings/pinctrl/at91.h |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 include/dt-bindings/pinctrl/at91.h

diff --git a/include/dt-bindings/pinctrl/at91.h b/include/dt-bindings/pinctrl/at91.h
new file mode 100644
index 0000000..d7988b4
--- /dev/null
+++ b/include/dt-bindings/pinctrl/at91.h
@@ -0,0 +1,35 @@
+/*
+ * This header provides constants for most at91 pinctrl bindings.
+ *
+ * Copyright (C) 2013 Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
+ *
+ * GPLv2 only
+ */
+
+#ifndef __DT_BINDINGS_AT91_PINCTRL_H__
+#define __DT_BINDINGS_AT91_PINCTRL_H__
+
+#define AT91_PINCTRL_NONE		(0 << 0)
+#define AT91_PINCTRL_PULL_UP		(1 << 0)
+#define AT91_PINCTRL_MULTI_DRIVE	(1 << 1)
+#define AT91_PINCTRL_DEGLITCH		(1 << 2)
+#define AT91_PINCTRL_PULL_DOWN		(1 << 3)
+#define AT91_PINCTRL_DIS_SCHMIT		(1 << 4)
+#define AT91_PINCTRL_DEBOUNCE		(1 << 16)
+#define AT91_PINCTRL_DEBOUNCE_VA(x)	(x << 17)
+
+#define AT91_PINCTRL_PULL_UP_DEGLITCH	(AT91_PINCTRL_PULL_UP | AT91_PINCTRL_DEGLITCH)
+
+#define AT91_PIOA	0
+#define AT91_PIOB	1
+#define AT91_PIOC	2
+#define AT91_PIOD	3
+#define AT91_PIOE	4
+
+#define AT91_PERIPH_GPIO	0
+#define AT91_PERIPH_A		1
+#define AT91_PERIPH_B		2
+#define AT91_PERIPH_C		3
+#define AT91_PERIPH_D		4
+
+#endif /* __DT_BINDINGS_AT91_PINCTRL_H__ */
-- 
1.7.10.4
