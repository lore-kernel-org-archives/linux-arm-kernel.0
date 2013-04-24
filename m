From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 24 Apr 2013 16:58:06 +0200
Subject: [PATCH 1/3] ARM: at91: dt: add pinctrl pre-processor define
In-Reply-To: <20130424145627.GL4998@game.jcrosoft.org>
References: <20130424145627.GL4998@game.jcrosoft.org>
Message-ID: <1366815488-27976-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/boot/dts/at91-pinctrl.h |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 arch/arm/boot/dts/at91-pinctrl.h

diff --git a/arch/arm/boot/dts/at91-pinctrl.h b/arch/arm/boot/dts/at91-pinctrl.h
new file mode 100644
index 0000000..d7988b4
--- /dev/null
+++ b/arch/arm/boot/dts/at91-pinctrl.h
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
