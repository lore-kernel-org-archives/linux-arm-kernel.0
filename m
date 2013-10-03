From: tipbot@zytor.com (tip-bot for Kevin Hilman)
Date: Thu, 3 Oct 2013 06:57:53 -0700
Subject: [tip:timers/core] nohz:
 Drop generic vtime obsolete dependency on CONFIG_64BIT
Message-ID: <tip-ff3fb2541246a83ce56c61d14df30b7a22e4302b@git.kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit-ID:  ff3fb2541246a83ce56c61d14df30b7a22e4302b
Gitweb:     http://git.kernel.org/tip/ff3fb2541246a83ce56c61d14df30b7a22e4302b
Author:     Kevin Hilman <khilman@linaro.org>
AuthorDate: Mon, 16 Sep 2013 15:28:19 -0700
Committer:  Frederic Weisbecker <fweisbec@gmail.com>
CommitDate: Mon, 30 Sep 2013 15:37:01 +0200

nohz: Drop generic vtime obsolete dependency on CONFIG_64BIT

The CONFIG_64BIT requirement on vtime can finally be removed
since we now depend on HAVE_VIRT_CPU_ACCOUNTING_GEN which
already takes care of the arch ability to handle nsecs based
cputime_t safely.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Russell King <rmk@arm.linux.org.uk>
Cc: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
Cc: Arm Linux <linux-arm-kernel@lists.infradead.org>
Signed-off-by: Frederic Weisbecker <fweisbec@gmail.com>
---
 init/Kconfig        | 2 +-
 kernel/time/Kconfig | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/init/Kconfig b/init/Kconfig
index 68c1a0e..841e79c 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -354,7 +354,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING && 64BIT
+	depends on HAVE_CONTEXT_TRACKING
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index f148475..3ce6e8c 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -100,7 +100,6 @@ config NO_HZ_FULL
 	# RCU_USER_QS dependency
 	depends on HAVE_CONTEXT_TRACKING
 	# VIRT_CPU_ACCOUNTING_GEN dependency
-	depends on 64BIT
 	depends on HAVE_VIRT_CPU_ACCOUNTING_GEN
 	select NO_HZ_COMMON
 	select RCU_USER_QS
