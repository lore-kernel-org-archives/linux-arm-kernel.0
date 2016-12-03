From: marc.zyngier@arm.com (Marc Zyngier)
Date: Sat,  3 Dec 2016 14:05:37 +0000
Subject: [PATCH 1/2] arm64: Remove reference to asm/opcodes.h
In-Reply-To: <20161203140538.23525-1-marc.zyngier@arm.com>
References: <20161203140538.23525-1-marc.zyngier@arm.com>
Message-ID: <20161203140538.23525-2-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The asm/opcodes.h file is now gone, but probes.h still references it
for not obvious reason. Removing the #include directive fixes
the compilation.

Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
---
 arch/arm64/include/asm/probes.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/include/asm/probes.h b/arch/arm64/include/asm/probes.h
index e175a82..6a5b289 100644
--- a/arch/arm64/include/asm/probes.h
+++ b/arch/arm64/include/asm/probes.h
@@ -15,8 +15,6 @@
 #ifndef _ARM_PROBES_H
 #define _ARM_PROBES_H
 
-#include <asm/opcodes.h>
-
 typedef u32 probe_opcode_t;
 typedef void (probes_handler_t) (u32 opcode, long addr, struct pt_regs *);
 
-- 
2.10.2
