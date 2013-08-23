From: lee.jones@linaro.org (Lee Jones)
Date: Fri, 23 Aug 2013 13:23:08 +0100
Subject: [PATCH 08/40] ARM: ux500: Disable Snowball's CPUFreq functionality
 when booting with ATAGs enabled
In-Reply-To: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
References: <1377260620-18829-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1377260620-18829-9-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's time to remove all ATAG support from ux500 and rely solely on
Device Tree booting. This patch is part of that endeavour.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 68bd9d3..deda6a1 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -108,10 +108,6 @@ struct ab8500_platform_data ab8500_platdata = {
 	.codec		= &ab8500_codec_pdata,
 };
 
-static struct platform_device u8500_cpufreq_cooling_device = {
-	.name           = "db8500-cpufreq-cooling",
-};
-
 /*
  * TC35892
  */
@@ -351,7 +347,6 @@ static void __init u8500_cryp1_hash1_init(struct device *parent)
 }
 
 static struct platform_device *snowball_platform_devs[] __initdata = {
-	&u8500_cpufreq_cooling_device,
 	&sdi0_regulator,
 };
 
-- 
1.8.1.2
