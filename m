From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Dec 2012 17:53:12 +0000
Subject: [PATCH v3 2/6] ARM: opcodes: add opcodes definitions for ARM security
 extensions
In-Reply-To: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
References: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
Message-ID: <1355853196-23676-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM security extensions introduced the smc instruction, which is not
supported by all versions of GAS.

This patch introduces opcodes-sec.h, so that smc is made available in a
similar manner to hvc.

Acked-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/opcodes-sec.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)
 create mode 100644 arch/arm/include/asm/opcodes-sec.h

diff --git a/arch/arm/include/asm/opcodes-sec.h b/arch/arm/include/asm/opcodes-sec.h
new file mode 100644
index 0000000..bc3a917
--- /dev/null
+++ b/arch/arm/include/asm/opcodes-sec.h
@@ -0,0 +1,24 @@
+/*
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * Copyright (C) 2012 ARM Limited
+ */
+
+#ifndef __ASM_ARM_OPCODES_SEC_H
+#define __ASM_ARM_OPCODES_SEC_H
+
+#include <asm/opcodes.h>
+
+#define __SMC(imm4) __inst_arm_thumb32(					\
+	0xE1600070 | (((imm4) & 0xF) << 0),				\
+	0xF7F08000 | (((imm4) & 0xF) << 16)				\
+)
+
+#endif /* __ASM_ARM_OPCODES_SEC_H */
-- 
1.8.0
