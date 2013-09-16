From: khilman@linaro.org (Kevin Hilman)
Date: Mon, 16 Sep 2013 15:28:19 -0700
Subject: [PATCH 1/4] nohz_full: Kconfig: VIRT_CPU_ACCOUNTING_GEN: drop 64-bit
 requirement
In-Reply-To: <1379370502-30376-1-git-send-email-khilman@linaro.org>
References: <1379370502-30376-1-git-send-email-khilman@linaro.org>
Message-ID: <1379370502-30376-2-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64-bit requirement can be removed since the conversion of the nsec
granularity cputime to work on !64_BIT

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 18bd9e3..e9cd23b 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -354,7 +354,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING && 64BIT
+	depends on HAVE_CONTEXT_TRACKING
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
-- 
1.8.3
