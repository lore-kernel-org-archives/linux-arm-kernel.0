From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  1 Jun 2011 10:44:52 +0100
Subject: [PATCH 4/5] ARM: S3C6410: Support 800MHz operation in cpufreq
In-Reply-To: <1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1306921493-30911-4-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least some newer S3C6410 silicon supports operation up to 800MHz rather
than just 667MHz. Unfortunately I don't have access to any of documentation
of this other than some running systems, add a new cpufreq table entry for
this based on the behaviour of those systems.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/cpufreq/s3c64xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx.c b/drivers/cpufreq/s3c64xx.c
index fc3f180..fc69178 100644
--- a/drivers/cpufreq/s3c64xx.c
+++ b/drivers/cpufreq/s3c64xx.c
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
