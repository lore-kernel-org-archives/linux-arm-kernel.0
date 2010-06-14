From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Mon, 14 Jun 2010 17:39:14 +0900
Subject: [PATCH 5/6] S5PV210 added EINT-GPIO register mappings
In-Reply-To: <1276504755-24741-5-git-send-email-MyungJoo.Ham@samsung.com>
References: <1276504755-24741-1-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-2-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-3-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-4-git-send-email-MyungJoo.Ham@samsung.com>
	<1276504755-24741-5-git-send-email-MyungJoo.Ham@samsung.com>
Message-ID: <1276504755-24741-6-git-send-email-MyungJoo.Ham@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: MyungJoo Ham <MyungJoo.Ham@samsung.com>
---
 arch/arm/plat-s5p/include/plat/gpio-ext.h |   44 +++++++++++++++++++++++++++++
 1 files changed, 44 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/plat-s5p/include/plat/gpio-ext.h

diff --git a/arch/arm/plat-s5p/include/plat/gpio-ext.h b/arch/arm/plat-s5p/include/plat/gpio-ext.h
new file mode 100644
index 0000000..b298335
--- /dev/null
+++ b/arch/arm/plat-s5p/include/plat/gpio-ext.h
@@ -0,0 +1,44 @@
+/* linux/arch/arm/plat-s5p/include/plat/gpio-eint.h
+ *
+ * Copyright 2009 Samsung Electronics Co.
+ *
+ * External Interrupt (GPH0 ~ GPH3) control register definitions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#define S5P_WKUP_INT_CON0_7		(S5P_EINT_BASE + 0x0)
+#define S5P_WKUP_INT_CON8_15		(S5P_EINT_BASE + 0x4)
+#define S5P_WKUP_INT_CON16_23		(S5P_EINT_BASE + 0x8)
+#define S5P_WKUP_INT_CON24_31		(S5P_EINT_BASE + 0xC)
+#define S5P_WKUP_INT_CON(x)		(S5P_WKUP_INT_CON0_7 + (x * 0x4))
+
+#define S5P_WKUP_INT_FLTCON0_3		(S5P_EINT_BASE + 0x80)
+#define S5P_WKUP_INT_FLTCON4_7		(S5P_EINT_BASE + 0x84)
+#define S5P_WKUP_INT_FLTCON8_11		(S5P_EINT_BASE + 0x88)
+#define S5P_WKUP_INT_FLTCON12_15	(S5P_EINT_BASE + 0x8C)
+#define S5P_WKUP_INT_FLTCON16_19	(S5P_EINT_BASE + 0x90)
+#define S5P_WKUP_INT_FLTCON20_23	(S5P_EINT_BASE + 0x94)
+#define S5P_WKUP_INT_FLTCON24_27	(S5P_EINT_BASE + 0x98)
+#define S5P_WKUP_INT_FLTCON28_31	(S5P_EINT_BASE + 0x9C)
+#define S5P_WKUP_INT_FLTCON(x)		(S5P_WKUP_INT_FLTCON0_3 + (x * 0x4))
+
+#define S5P_WKUP_INT_MASK0_7		(S5P_EINT_BASE + 0x100)
+#define S5P_WKUP_INT_MASK8_15		(S5P_EINT_BASE + 0x104)
+#define S5P_WKUP_INT_MASK16_23		(S5P_EINT_BASE + 0x108)
+#define S5P_WKUP_INT_MASK24_31		(S5P_EINT_BASE + 0x10C)
+#define S5P_WKUP_INT_MASK(x)		(S5P_WKUP_INT_MASK0_7 + (x * 0x4))
+
+#define S5P_WKUP_INT_PEND0_7		(S5P_EINT_BASE + 0x140)
+#define S5P_WKUP_INT_PEND8_15		(S5P_EINT_BASE + 0x144)
+#define S5P_WKUP_INT_PEND16_23		(S5P_EINT_BASE + 0x148)
+#define S5P_WKUP_INT_PEND24_31		(S5P_EINT_BASE + 0x14C)
+#define S5P_WKUP_INT_PEND(x)		(S5P_WKUP_INT_PEND0_7 + (x * 0x4))
+
+#define S5P_WKUP_INT_LOWLEV		(0x00)
+#define S5P_WKUP_INT_HILEV		(0x01)
+#define S5P_WKUP_INT_FALLEDGE		(0x02)
+#define S5P_WKUP_INT_RISEEDGE		(0x03)
+#define S5P_WKUP_INT_BOTHEDGE		(0x04)
-- 
1.6.3.3
