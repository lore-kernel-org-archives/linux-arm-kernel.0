From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 17 Nov 2015 18:14:19 +0000
Subject: [PATCH] cpufreq: scpi: Add dependency on SCPI clk driver
Message-ID: <1447784059-22769-1-git-send-email-punit.agrawal@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCPI clk driver registers the virtual cpufreq device that kicks off
initialisation of the SCPI cpufreq driver. Make the dependendency
explicit in Kconfig.

Fixes: 8def31034d03 ("cpufreq: arm_big_little: add SCPI interface driver")
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 1582c1c..dadfdd4 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -201,7 +201,7 @@ config ARM_SA1110_CPUFREQ
 
 config ARM_SCPI_CPUFREQ
         tristate "SCPI based CPUfreq driver"
-	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL
+	depends on ARM_BIG_LITTLE_CPUFREQ && ARM_SCPI_PROTOCOL && COMMON_CLK_SCPI
         help
 	  This adds the CPUfreq driver support for ARM big.LITTLE platforms
 	  using SCPI protocol for CPU power management.
-- 
2.6.2
