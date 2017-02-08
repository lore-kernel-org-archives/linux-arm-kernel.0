From: yuantian.tang@nxp.com (yuantian.tang at nxp.com)
Date: Wed, 8 Feb 2017 13:43:04 +0800
Subject: [PATCH 1/2 v2] cpufreq: qoriq: added arm64 socs support
Message-ID: <1486532585-36463-1-git-send-email-yuantian.tang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tang Yuantian <Yuantian.Tang@nxp.com>

Add arm64 config to Kconfig to enable cpu frequency feature on
nxp arm64 socs.

Signed-off-by: Tang Yuantian <yuantian.tang@nxp.com>
---
v2:
  - no change

 drivers/cpufreq/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 15adef4..3964383 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -324,7 +324,7 @@ endif
 
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
-	depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
+	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
 	depends on !CPU_THERMAL || THERMAL
 	select CLK_QORIQ
 	help
-- 
2.1.0.27.g96db324
