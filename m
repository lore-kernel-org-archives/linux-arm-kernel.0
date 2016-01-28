From: jeffmerkey@gmail.com (Jeffrey Merkey)
Date: Thu, 28 Jan 2016 12:47:52 -0700
Subject: [PATCH 31/31] Add debugger entry points for ARM64
Message-ID: <1454010472-29693-1-git-send-email-jeffmerkey@gmail.com>
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
 arch/arm64/include/asm/kdebug.h | 4 ++++
 1 file changed, 4 insertions(+)
 create mode 100644 arch/arm64/include/asm/kdebug.h

diff --git a/arch/arm64/include/asm/kdebug.h b/arch/arm64/include/asm/kdebug.h
new file mode 100644
index 0000000..5d09de1
--- /dev/null
+++ b/arch/arm64/include/asm/kdebug.h
@@ -0,0 +1,4 @@
+
+static inline void arch_breakpoint(void)
+{
+}
-- 
1.8.3.1
