From: fweisbec@gmail.com (Frederic Weisbecker)
Date: Mon, 30 Sep 2013 16:06:52 +0200
Subject: [PATCH 3/3] ARM: Kconfig: allow full nohz CPU accounting
In-Reply-To: <1380550012-7321-1-git-send-email-fweisbec@gmail.com>
References: <1380550012-7321-1-git-send-email-fweisbec@gmail.com>
Message-ID: <1380550012-7321-4-git-send-email-fweisbec@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kevin Hilman <khilman@linaro.org>

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
-- 
1.8.3.1
