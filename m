From: magnus.damm@gmail.com (Magnus Damm)
Date: Wed, 06 Oct 2010 16:18:13 +0900
Subject: [PATCH 05/08] ARM: Move the unwind header to entry-header.S
In-Reply-To: <20101006071731.28048.89938.sendpatchset@t400s>
References: <20101006071731.28048.89938.sendpatchset@t400s>
Message-ID: <20101006071813.28048.36531.sendpatchset@t400s>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Include the unwind header in entry-header.S.

This way we save space in the IRQ demux file.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/include/asm/entry-header.S |    1 +
 arch/arm/kernel/entry-armv.S        |    1 -
 arch/arm/kernel/entry-common.S      |    1 -
 3 files changed, 1 insertion(+), 2 deletions(-)

--- 0005/arch/arm/include/asm/entry-header.S
+++ work/arch/arm/include/asm/entry-header.S	2010-10-06 14:30:10.000000000 +0900
@@ -5,6 +5,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/errno.h>
 #include <asm/thread_info.h>
+#include <asm/unwind.h>
 
 @ Bad Abort numbers
 @ -----------------
--- 0005/arch/arm/kernel/entry-armv.S
+++ work/arch/arm/kernel/entry-armv.S	2010-10-06 14:30:14.000000000 +0900
@@ -20,7 +20,6 @@
 #include <asm/vfpmacros.h>
 #include <mach/entry-macro.S>
 #include <asm/thread_notify.h>
-#include <asm/unwind.h>
 #include <asm/unistd.h>
 #include <asm/tls.h>
 #include <asm/entry-header.S>
--- 0002/arch/arm/kernel/entry-common.S
+++ work/arch/arm/kernel/entry-common.S	2010-10-06 14:30:20.000000000 +0900
@@ -11,7 +11,6 @@
 #include <asm/unistd.h>
 #include <asm/ftrace.h>
 #include <mach/entry-macro.S>
-#include <asm/unwind.h>
 #include <asm/entry-header.S>
 
 
