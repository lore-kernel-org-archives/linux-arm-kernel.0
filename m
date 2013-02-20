From: khilman@linaro.org (Kevin Hilman)
Date: Wed, 20 Feb 2013 11:41:40 -0800
Subject: [RFC/PATCH 3/5] virt CPU accounting: Kconfig: drop 64-bit requirment
In-Reply-To: <1361389302-11968-1-git-send-email-khilman@linaro.org>
References: <1361389302-11968-1-git-send-email-khilman@linaro.org>
Message-ID: <1361389302-11968-4-git-send-email-khilman@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 64-bit requirement can be removed after the conversion of
kernel_cpustat accessors to the portable atomic64 accessors.

Signed-off-by: Kevin Hilman <khilman@linaro.org>
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 3abb019..b13af06 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -356,7 +356,7 @@ config VIRT_CPU_ACCOUNTING_NATIVE
 
 config VIRT_CPU_ACCOUNTING_GEN
 	bool "Full dynticks CPU time accounting"
-	depends on HAVE_CONTEXT_TRACKING && 64BIT
+	depends on HAVE_CONTEXT_TRACKING
 	select VIRT_CPU_ACCOUNTING
 	select CONTEXT_TRACKING
 	help
-- 
1.8.1.2
