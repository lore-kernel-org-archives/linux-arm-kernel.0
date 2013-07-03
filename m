From: khilman@linaro.org (Kevin Hilman)
Date: Wed,  3 Jul 2013 11:36:39 -0700
Subject: [PATCH 1/3] nohz: Kconfig: remove redundant 64-bit dependency
In-Reply-To: <1372876601-23881-1-git-send-email-khilman@linaro.org>
References: <1372876601-23881-1-git-send-email-khilman@linaro.org>
Message-ID: <1372876601-23881-2-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The current 64-bit dependency is on VIRT_CPU_ACCOUNTING_GEN, which already
has its own dependency on 64-bit.  Remove it from NO_HZ_FULL.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 kernel/time/Kconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 70f27e8..b78760f 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -99,8 +99,6 @@ config NO_HZ_FULL
 	depends on SMP
 	# RCU_USER_QS dependency
 	depends on HAVE_CONTEXT_TRACKING
-	# VIRT_CPU_ACCOUNTING_GEN dependency
-	depends on 64BIT
 	select NO_HZ_COMMON
 	select RCU_USER_QS
 	select RCU_NOCB_CPU
-- 
1.8.3
