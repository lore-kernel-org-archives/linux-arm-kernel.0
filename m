From: ben@smart-cactus.org (Ben Gamari)
Date: Wed,  2 Dec 2015 22:19:27 +0100
Subject: [PATCH 12/12] cpufreq: arm-big-little: warn on invalid regulator
In-Reply-To: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
References: <1449091167-20758-1-git-send-email-ben@smart-cactus.org>
Message-ID: <1449091167-20758-13-git-send-email-ben@smart-cactus.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
---
 drivers/cpufreq/arm_big_little.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little.c b/drivers/cpufreq/arm_big_little.c
index 2d5761c..5d30c26 100644
--- a/drivers/cpufreq/arm_big_little.c
+++ b/drivers/cpufreq/arm_big_little.c
@@ -158,6 +158,9 @@ bL_cpufreq_set_rate_cluster(u32 cpu, u32 cluster, u32 new_rate_kHz)
 		volt_old = regulator_get_voltage(reg[cluster]);
 		pr_debug("%s: cpu %d, cluster: %d, Found OPP: %ld kHz, %ld uV\n",
 			__func__, cpu, cluster, opp_freq / 1000, volt);
+	} else {
+		pr_err("%s: cpu %d, cluster: %d, Have no regulator\n",
+					 __func__, cpu, cluster);
 	}
 
 	pr_debug("%s: cpu %d, cluster: %d, %u MHz, %ld mV --> %u MHz, %ld mV\n",
-- 
2.6.2
