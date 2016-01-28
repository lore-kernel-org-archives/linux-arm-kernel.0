From: jeffmerkey@gmail.com (Jeffrey Merkey)
Date: Thu, 28 Jan 2016 12:47:04 -0700
Subject: [PATCH 17/31] Add debugger entry points for ARM
Message-ID: <1454010424-29097-1-git-send-email-jeffmerkey@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds an export which can be set by system debuggers to
direct the hard lockup and soft lockup detector to trigger a breakpoint
exception and enter a debugger if one is active.  It is assumed that if
someone sets this variable, then an breakpoint handler of some sort will
be actively loaded or registered via the notify die handler chain.

This addition is extremely useful for debugging hard and soft lockups
real time and quickly from a console debugger.

Signed-off-by: Jeffrey Merkey <jeffmerkey@gmail.com>
---
 arch/arm/include/asm/kdebug.h | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 arch/arm/include/asm/kdebug.h

diff --git a/arch/arm/include/asm/kdebug.h b/arch/arm/include/asm/kdebug.h
new file mode 100644
index 0000000..c60dad1
--- /dev/null
+++ b/arch/arm/include/asm/kdebug.h
@@ -0,0 +1,5 @@
+
+static inline void arch_breakpoint(void)
+{
+	asm(__inst_arm(0xe7ffdeff));
+}
-- 
1.8.3.1
