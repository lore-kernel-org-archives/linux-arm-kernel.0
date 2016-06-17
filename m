From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Fri, 17 Jun 2016 16:05:06 +0100
Subject: [PATCH 2/9] ARM: fix missing include of <asm/insn.h> in
 arch/arm/kernel/insn.c
In-Reply-To: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
References: <1466175913-19067-1-git-send-email-ben.dooks@codethink.co.uk>
Message-ID: <1466175913-19067-3-git-send-email-ben.dooks@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the warning by including <asm/insn.h> for the declaration
of __arm_gen_branch().

arm/kernel/insn.c:56:1: warning: symbol '__arm_gen_branch' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/kernel/insn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/insn.c b/arch/arm/kernel/insn.c
index b760340..5438934 100644
--- a/arch/arm/kernel/insn.c
+++ b/arch/arm/kernel/insn.c
@@ -1,6 +1,7 @@
 #include <linux/bug.h>
 #include <linux/kernel.h>
 #include <asm/opcodes.h>
+#include <asm/insn.h>
 
 static unsigned long
 __arm_gen_branch_thumb2(unsigned long pc, unsigned long addr, bool link)
-- 
2.8.1
