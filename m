From: viresh.kumar@st.com (Viresh KUMAR)
Date: Thu, 25 Mar 2010 14:10:44 +0530
Subject: [PATCH V2 Resend 01/12] ST SPEAr: Added ARM PrimeXsys System
	Controller SP810 header file
In-Reply-To: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
References: <1269506455-15173-1-git-send-email-viresh.kumar@st.com>
Message-ID: <1269506455-15173-2-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/include/asm/hardware/sp810.h |   59 +++++++++++++++++++++++++++++++++
 1 files changed, 59 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/include/asm/hardware/sp810.h

diff --git a/arch/arm/include/asm/hardware/sp810.h b/arch/arm/include/asm/hardware/sp810.h
new file mode 100644
index 0000000..a101f10
--- /dev/null
+++ b/arch/arm/include/asm/hardware/sp810.h
@@ -0,0 +1,59 @@
+/*
+ * arch/arm/include/asm/hardware/sp810.h
+ *
+ * ARM PrimeXsys System Controller SP810 header file
+ *
+ * Copyright (C) 2009 ST Microelectronics
+ * Viresh Kumar<viresh.kumar@st.com>
+ *
+ * This file is licensed under the terms of the GNU General Public
+ * License version 2. This program is licensed "as is" without any
+ * warranty of any kind, whether express or implied.
+ */
+
+#ifndef __ASM_ARM_SP810_H
+#define __ASM_ARM_SP810_H
+
+#include <linux/io.h>
+
+/* sysctl registers offset */
+#define SCCTRL			0x000
+#define SCSYSSTAT		0x004
+#define SCIMCTRL		0x008
+#define SCIMSTAT		0x00C
+#define SCXTALCTRL		0x010
+#define SCPLLCTRL		0x014
+#define SCPLLFCTRL		0x018
+#define SCPERCTRL0		0x01C
+#define SCPERCTRL1		0x020
+#define SCPEREN			0x024
+#define SCPERDIS		0x028
+#define SCPERCLKEN		0x02C
+#define SCPERSTAT		0x030
+#define SCSYSID0		0xEE0
+#define SCSYSID1		0xEE4
+#define SCSYSID2		0xEE8
+#define SCSYSID3		0xEEC
+#define SCITCR			0xF00
+#define SCITIR0			0xF04
+#define SCITIR1			0xF08
+#define SCITOR			0xF0C
+#define SCCNTCTRL		0xF10
+#define SCCNTDATA		0xF14
+#define SCCNTSTEP		0xF18
+#define SCPERIPHID0		0xFE0
+#define SCPERIPHID1		0xFE4
+#define SCPERIPHID2		0xFE8
+#define SCPERIPHID3		0xFEC
+#define SCPCELLID0		0xFF0
+#define SCPCELLID1		0xFF4
+#define SCPCELLID2		0xFF8
+#define SCPCELLID3		0xFFC
+
+static inline void sysctl_soft_reset(void __iomem *base)
+{
+	/* writing any value to SCSYSSTAT reg will reset system */
+	writel(0, base + SCSYSSTAT);
+}
+
+#endif	/* __ASM_ARM_SP810_H */
-- 
1.6.0.2
