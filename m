From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Dec 2012 17:53:11 +0000
Subject: [PATCH v3 1/6] ARM: opcodes: add missing include of linux/linkage.h
In-Reply-To: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
References: <1355853196-23676-1-git-send-email-will.deacon@arm.com>
Message-ID: <1355853196-23676-2-git-send-email-will.deacon@arm.com>
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
