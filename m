From: Dave.Martin@arm.com (Dave Martin)
Date: Thu,  3 Aug 2017 17:23:19 +0100
Subject: [PATCH 1/5] arm64: neon: replace generic definition of may_use_simd()
In-Reply-To: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
References: <1501777403-9782-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <1501777403-9782-2-git-send-email-Dave.Martin@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

In preparation of modifying the logic that decides whether kernel mode
NEON is allowable, which is required for SVE support, introduce an
implementation of may_use_simd() that reflects the current reality, i.e.,
that SIMD is allowed in any context.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Reviewed-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/include/asm/Kbuild |  1 -
 arch/arm64/include/asm/simd.h | 23 +++++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/simd.h

diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
index f81c7b6..2326e39 100644
--- a/arch/arm64/include/asm/Kbuild
+++ b/arch/arm64/include/asm/Kbuild
@@ -20,7 +20,6 @@ generic-y += rwsem.h
 generic-y += segment.h
 generic-y += serial.h
 generic-y += set_memory.h
-generic-y += simd.h
 generic-y += sizes.h
 generic-y += switch_to.h
 generic-y += trace_clock.h
diff --git a/arch/arm64/include/asm/simd.h b/arch/arm64/include/asm/simd.h
new file mode 100644
index 0000000..96959b5
--- /dev/null
+++ b/arch/arm64/include/asm/simd.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2017 Linaro Ltd. <ard.biesheuvel@linaro.org>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License version 2 as published
+ * by the Free Software Foundation.
+ */
+
+#ifndef __ASM_SIMD_H
+#define __ASM_SIMD_H
+
+#include <linux/types.h>
+
+/*
+ * may_use_simd - whether it is allowable at this time to issue SIMD
+ *                instructions or access the SIMD register file
+ */
+static __must_check inline bool may_use_simd(void)
+{
+	return true;
+}
+
+#endif
-- 
2.1.4
