From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 25 Apr 2014 21:20:08 +0800
Subject: [PATCH v3 part1 02/11] ARM64 / ACPI: Introduce the skeleton of _PDC
 related for ARM64
In-Reply-To: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
Message-ID: <1398432017-8506-3-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The _PDC (Processor Driver Capabilities) object provides OSPM a
mechanism to convey to the platform the capabilities supported
by OSPM for processor power management.

OSPM evaluates _PDC prior to evaluating any other processor
power management objects returning configuration information.

This patch introduces the skeleton of _PDC related file to make
ACPI core can be compiled on ARM64, and should be revisited when
implementing CPU power control.

Signed-off-by: Al Stone <al.stone@linaro.org>
Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/include/asm/acpi.h |   37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 arch/arm64/include/asm/acpi.h

diff --git a/arch/arm64/include/asm/acpi.h b/arch/arm64/include/asm/acpi.h
new file mode 100644
index 0000000..e3e990e
--- /dev/null
+++ b/arch/arm64/include/asm/acpi.h
@@ -0,0 +1,37 @@
+/*
+ *  Copyright (C) 2013~2014, Al Stone <al.stone@linaro.org>
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ */
+
+#ifndef _ASM_ACPI_H
+#define _ASM_ACPI_H
+
+static inline bool arch_has_acpi_pdc(void)
+{
+	/*
+	 * Always false for now, should be revisited when
+	 * implementing CPU power management
+	 */
+	return false;
+}
+
+static inline void arch_acpi_set_pdc_bits(u32 *buf)
+{
+	/* Should be revisited when implementing CPU power management */
+	return;
+}
+
+#endif /*_ASM_ACPI_H*/
-- 
1.7.9.5
