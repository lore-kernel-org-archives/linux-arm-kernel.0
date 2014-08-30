From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 30 Aug 2014 18:46:12 +0200
Subject: [Patch v3] 7/7] cpufreq: Remove ARCH_KIRKWOOD dependency
In-Reply-To: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
References: <1409417172-6846-1-git-send-email-andrew@lunn.ch>
Message-ID: <1409417172-6846-8-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood has been removed, now that kirkwood lives in mach-mvebu.
ARCH_MVEBU is sufficient.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 7364a538e056..8c5cf4bdeab8 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -119,7 +119,7 @@ config ARM_INTEGRATOR
 	  If in doubt, say Y.
 
 config ARM_KIRKWOOD_CPUFREQ
-	def_bool ARCH_KIRKWOOD || MACH_KIRKWOOD
+	def_bool MACH_KIRKWOOD
 	help
 	  This adds the CPUFreq driver for Marvell Kirkwood
 	  SoCs.
-- 
2.1.0
