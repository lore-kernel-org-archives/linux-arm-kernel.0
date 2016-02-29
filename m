From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Feb 2016 17:04:20 +0100
Subject: [PATCH 1/2] cpufreq: qoriq: allow building as module with THERMAL=m
Message-ID: <1456761867-1742824-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

My previous patch to avoid link errors with the qoriq cpufreq
driver disallowed all of the broken cases, but also prevented
the driver from being built when CONFIG_THERMAL is a module.

This changes the dependency to allow the cpufreq driver to
also be a module in this case, just not built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: cpufreq: qoriq depends on thermal
---

If possible, please fold this change directly into the previous
commit

 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index ca05037dd565..d5e11d24f72b 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -297,7 +297,7 @@ endif
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
 	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
-	depends on !CPU_THERMAL || THERMAL=y
+	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
-- 
2.7.0
