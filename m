From: will.deacon@arm.com (Will Deacon)
Date: Mon, 17 Dec 2012 16:35:36 +0000
Subject: [PATCH v2 1/6] ARM: opcodes: add missing include of linux/linkage.h
In-Reply-To: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
References: <1355762141-29616-1-git-send-email-will.deacon@arm.com>
Message-ID: <1355762141-29616-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

opcodes.h wants to declare an asmlinkage function, so we need to include
linux/linkage.h

Acked-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/include/asm/opcodes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/opcodes.h b/arch/arm/include/asm/opcodes.h
index 74e211a..e796c59 100644
--- a/arch/arm/include/asm/opcodes.h
+++ b/arch/arm/include/asm/opcodes.h
@@ -10,6 +10,7 @@
 #define __ASM_ARM_OPCODES_H
 
 #ifndef __ASSEMBLY__
+#include <linux/linkage.h>
 extern asmlinkage unsigned int arm_check_condition(u32 opcode, u32 psr);
 #endif
 
-- 
1.8.0
