From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Mar 2013 16:34:26 -0700
Subject: [PATCH 2/3] init/Kconfig: virt CPU accounting: drop 64-bit requirment
In-Reply-To: <1363822467-6275-1-git-send-email-khilman@linaro.org>
References: <1363822467-6275-1-git-send-email-khilman@linaro.org>
Message-ID: <1363822467-6275-3-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64-bit requirement can be removed after the conversion of
the conversion of the nsec granularity cputime to work on !64_BIT

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 8a1dac2..1f1a328 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -329,7 +329,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING && 64BIT
+	depends on HAVE_CONTEXT_TRACKING
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
-- 
1.8.2
