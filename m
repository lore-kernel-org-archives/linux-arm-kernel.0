From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 28 Apr 2011 16:26:23 +0100
Subject: [PATCH] ARM: S3C6410: Add some lower frequencies for 800MHz base
	clock operation
Message-ID: <1304004383-16133-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By extension from the 667MHz based clocks currently supported add 100MHz
and 200MHz operating points. Due to a lack of documentation these have not
been confirmed as supported but by extension from the existing frequencies
they should be OK and there is less risk than with the previuus patch for
800MHz operation.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---

In spite of the commit log this is based on top of the previous patch.

 arch/arm/mach-s3c64xx/cpufreq.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/cpufreq.c b/arch/arm/mach-s3c64xx/cpufreq.c
index db722a5..1e7df30 100644
--- a/arch/arm/mach-s3c64xx/cpufreq.c
+++ b/arch/arm/mach-s3c64xx/cpufreq.c
@@ -37,7 +37,9 @@ static struct s3c64xx_dvfs s3c64xx_dvfs_table[] = {
 
 static struct cpufreq_frequency_table s3c64xx_freq_table[] = {
 	{ 0,  66000 },
+	{ 0, 100000 },
 	{ 0, 133000 },
+	{ 1, 200000 },
 	{ 1, 222000 },
 	{ 1, 266000 },
 	{ 2, 333000 },
-- 
1.7.4.1
