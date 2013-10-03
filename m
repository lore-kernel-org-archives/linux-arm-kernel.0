From: tipbot@zytor.com (tip-bot for Kevin Hilman)
Date: Thu, 3 Oct 2013 06:58:03 -0700
Subject: [tip:timers/core] ARM: Kconfig: allow full nohz CPU accounting
Message-ID: <tip-31c1fc8187158cb80ccd57c19e024c55af901797@git.kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit-ID:  31c1fc8187158cb80ccd57c19e024c55af901797
Gitweb:     http://git.kernel.org/tip/31c1fc8187158cb80ccd57c19e024c55af901797
Author:     Kevin Hilman <khilman@linaro.org>
AuthorDate: Mon, 16 Sep 2013 15:28:22 -0700
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Mon, 30 Sep 2013 15:37:05 +0200

ARM: Kconfig: allow full nohz CPU accounting

With the 64-bit requirement removed from VIRT_CPU_ACCOUNTING_GEN,
allow ARM platforms to enable it.  Since VIRT_CPU_ACCOUNTING_GEN is a
dependency for full NO_HZ, this allows ARM platforms to enable full
NO_HZ as well.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Arm Linux <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6..323baf0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -54,6 +54,7 @@ config ARM
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_UID16
+	select HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select IRQ_FORCED_THREADING
 	select KTIME_SCALAR
 	select MODULES_USE_ELF_REL
