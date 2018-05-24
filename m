From: will.deacon@arm.com (Will Deacon)
Date: Thu, 24 May 2018 11:59:41 +0100
Subject: [PATCH 4/9] openrisc: Don't pull in all of linux/bitops.h in
 asm/cmpxchg.h
In-Reply-To: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
References: <1527159586-8578-1-git-send-email-will.deacon@arm.com>
Message-ID: <1527159586-8578-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The openrisc implementation of asm/cmpxchg.h pulls in linux/bitops.h
so that it can refer to BITS_PER_BYTE. It also transitively relies on
this pulling in linux/compiler.h for READ_ONCE.

Replace the #include with linux/bits.h and linux/compiler.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/openrisc/include/asm/cmpxchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/openrisc/include/asm/cmpxchg.h b/arch/openrisc/include/asm/cmpxchg.h
index d29f7db53906..f9cd43a39d72 100644
--- a/arch/openrisc/include/asm/cmpxchg.h
+++ b/arch/openrisc/include/asm/cmpxchg.h
@@ -16,8 +16,9 @@
 #ifndef __ASM_OPENRISC_CMPXCHG_H
 #define __ASM_OPENRISC_CMPXCHG_H
 
+#include  <linux/bits.h>
+#include  <linux/compiler.h>
 #include  <linux/types.h>
-#include  <linux/bitops.h>
 
 #define __HAVE_ARCH_CMPXCHG 1
 
-- 
2.1.4
