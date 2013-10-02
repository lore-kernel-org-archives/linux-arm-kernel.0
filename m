From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Wed,  2 Oct 2013 14:37:54 +0200
Subject: [PATCH 2/3] nohz: Drop generic vtime obsolete dependency on
 CONFIG_64BIT
In-Reply-To: <1380717475-11505-1-git-send-email-fweisbec@gmail.com>
References: <1380717475-11505-1-git-send-email-fweisbec@gmail.com>
Message-ID: <1380717475-11505-3-git-send-email-fweisbec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@linaro.org>

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
-- 
1.8.3.1
