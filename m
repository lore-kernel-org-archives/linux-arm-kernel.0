From: khilman@linaro.org (Kevin Hilman)
Date: Wed,  3 Jul 2013 11:36:40 -0700
Subject: [PATCH 2/3] init/Kconfig: VIRT_CPU_ACCOUNTING_GEN: drop 64-bit
 requirement
In-Reply-To: <1372876601-23881-1-git-send-email-khilman@linaro.org>
References: <1372876601-23881-1-git-send-email-khilman@linaro.org>
Message-ID: <1372876601-23881-3-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64-bit requirement can be removed after the conversion of the nsec
granularity cputime to work on !64_BIT, which was done in commit
8c23b80e (cputime_nsecs: use math64.h for nsec resolution conversion
helpers)

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 2d9b831..e151022 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -325,7 +325,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING && 64BIT
+	depends on HAVE_CONTEXT_TRACKING
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
-- 
1.8.3
