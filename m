From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  8 Jun 2011 14:49:15 +0100
Subject: [PATCH] [CPUFREQ] S3C6410: Support 800MHz operation in cpufreq
Message-ID: <1307540955-10086-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least some newer S3C6410 silicon supports operation up to 800MHz rather
than just 667MHz. Unfortunately I don't have access to any of documentation
of this other than some running systems, add a new cpufreq table entry for
this based on the behaviour of those systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

Kukjin already indicated on several occasions that he was happy with
this change but it never seems to get applied or an actual ack.

 drivers/cpufreq/s3c64xx-cpufreq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index fc3f180..fc69178 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -31,6 +31,7 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 	[1] = { 1050000, 1150000 },
 	[2] = { 1100000, 1150000 },
 	[3] = { 1200000, 1350000 },
+	[4] = { 1300000, 1350000 },
 };
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
@@ -43,6 +44,7 @@ static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 2, 532000 },
 	{ 2, 533000 },
 	{ 3, 667000 },
+	{ 4, 800000 },
 	{ 0, CPUFREQ_TABLE_END },
 };
 #endif
-- 
1.7.5.3
