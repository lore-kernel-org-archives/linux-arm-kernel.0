From: will.deacon@arm.com (Will Deacon)
Date: Fri,  1 Jun 2018 17:06:25 +0100
Subject: [PATCH v2 5/9] sh: Don't pull in all of linux/bitops.h in
 asm/cmpxchg-xchg.h
In-Reply-To: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
References: <1527869189-31512-1-git-send-email-will.deacon@arm.com>
Message-ID: <1527869189-31512-6-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sh implementation of asm/cmpxchg-xchg.h pulls in linux/bitops.h
so that it can refer to BITS_PER_BYTE. It also transitively relies on
this pulling in linux/compiler.h for READ_ONCE.

Replace the #include with linux/bits.h and linux/compiler.h

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/sh/include/asm/cmpxchg-xchg.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sh/include/asm/cmpxchg-xchg.h b/arch/sh/include/asm/cmpxchg-xchg.h
index 1e881f5db659..593a9704782b 100644
--- a/arch/sh/include/asm/cmpxchg-xchg.h
+++ b/arch/sh/include/asm/cmpxchg-xchg.h
@@ -8,7 +8,8 @@
  * This work is licensed under the terms of the GNU GPL, version 2.  See the
  * file "COPYING" in the main directory of this archive for more details.
  */
-#include <linux/bitops.h>
+#include <linux/bits.h>
+#include <linux/compiler.h>
 #include <asm/byteorder.h>
 
 /*
-- 
2.1.4
