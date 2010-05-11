From: virtuoso@slind.org (Alexander Shishkin)
Date: Tue, 11 May 2010 17:06:14 +0300
Subject: [PATCH 1/1] silence a bogus sparse warning in unwind.c
Message-ID: <1273586774-9604-1-git-send-email-virtuoso@slind.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The check for compiler which is supposed to miscompile unwind tables
clearly has nothing to do with sparse (which does not define necessary
macros anyway), so simply silence it.

Signed-off-by: Alexander Shishkin <virtuoso@slind.org>
---
 arch/arm/kernel/unwind.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/kernel/unwind.c b/arch/arm/kernel/unwind.c
index 50292cd..dd81a91 100644
--- a/arch/arm/kernel/unwind.c
+++ b/arch/arm/kernel/unwind.c
@@ -26,6 +26,7 @@
  * http://infocenter.arm.com/help/topic/com.arm.doc.subset.swdev.abi/index.html
  */
 
+#ifndef __CHECKER__
 #if !defined (__ARM_EABI__)
 #warning Your compiler does not have EABI support.
 #warning    ARM unwind is known to compile only with EABI compilers.
@@ -34,6 +35,7 @@
 #warning Your compiler is too buggy; it is known to not compile ARM unwind support.
 #warning    Change compiler or disable ARM_UNWIND option.
 #endif
+#endif /* __CHECKER__ */
 
 #include <linux/kernel.h>
 #include <linux/init.h>
-- 
1.7.1.1.g15764
