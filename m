From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Thu, 09 Jul 2015 17:43:36 +0200
Subject: [PATCH v2 2/7] cpufreq: opp: fix handling of turbo modes
In-Reply-To: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
References: <1436456621-29839-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1436456621-29839-3-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Turbo modes should be marked with CPUFREQ_BOOST_FREQ flag in
the frequency table entry.

Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Thomas Abraham <thomas.ab@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/cpufreq/cpufreq_opp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq_opp.c b/drivers/cpufreq/cpufreq_opp.c
index 773bcde..f0cf502 100644
--- a/drivers/cpufreq/cpufreq_opp.c
+++ b/drivers/cpufreq/cpufreq_opp.c
@@ -75,6 +75,8 @@ int dev_pm_opp_init_cpufreq_table(struct device *dev,
 		}
 		freq_table[i].driver_data = i;
 		freq_table[i].frequency = rate / 1000;
+		if (dev_pm_opp_get_turbo_mode_setting(opp) == true)
+			freq_table[i].flags |= CPUFREQ_BOOST_FREQ;
 	}
 
 	freq_table[i].driver_data = i;
-- 
1.9.1
