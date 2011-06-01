From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed,  1 Jun 2011 10:44:53 +0100
Subject: [PATCH 5/5] ARM: S3C6410: Add some lower frequencies for 800MHz base
	clock operation
In-Reply-To: <1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20110601094313.GA23122@opensource.wolfsonmicro.com>
	<1306921493-30911-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1306921493-30911-5-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By extension from the 667MHz based clocks currently supported add 100MHz
and 200MHz operating points. Due to a lack of documentation these have not
been confirmed as supported but by extension from the existing frequencies
they should be OK and there is less risk than with the previuus patch for
800MHz operation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/cpufreq/s3c64xx.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/cpufreq/s3c64xx.c b/drivers/cpufreq/s3c64xx.c
index fc69178..c370935 100644
--- a/drivers/cpufreq/s3c64xx.c
+++ b/drivers/cpufreq/s3c64xx.c
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
1.7.5.3
