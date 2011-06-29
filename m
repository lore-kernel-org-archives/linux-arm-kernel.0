From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 28 Jun 2011 20:26:49 -0700
Subject: [PATCH] [CPUFREQ] S3C6410: Add some lower frequencies for 800MHz base
	clock operation
Message-ID: <1309318009-24897-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By extension from the 667MHz based clocks currently supported add 100MHz
and 200MHz operating points. Due to a lack of documentation these have not
been confirmed as supported but by extension from the existing frequencies
they should be OK, and I've given them quite a bit of runtime testing.

The major risk is synchronization with the non-ARM clocks but as we
can't currently scale the ARM PLL the risk should be relatively low.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/cpufreq/s3c64xx-cpufreq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx-cpufreq.c b/drivers/cpufreq/s3c64xx-cpufreq.c
index e818248..b8d1d20 100644
--- a/drivers/cpufreq/s3c64xx-cpufreq.c
+++ b/drivers/cpufreq/s3c64xx-cpufreq.c
@@ -36,7 +36,9 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0,  66000 },
+	{ 0, 100000 },
 	{ 0, 133000 },
+	{ 1, 200000 },
 	{ 1, 222000 },
 	{ 1, 266000 },
 	{ 2, 333000 },
-- 
1.7.5.4
