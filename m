From: tony@atomide.com (Tony Lindgren)
Date: Thu, 18 Apr 2013 10:54:35 -0700
Subject: [PATCH 3/3] ARM: OMAP2+: Fix is_gpmc_muxed warning for H4
In-Reply-To: <20130418175303.7436.75241.stgit@muffinssi.local>
References: <20130418175303.7436.75241.stgit@muffinssi.local>
Message-ID: <20130418175435.7436.60372.stgit@muffinssi.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the following error by moving the function to be within
the smc91x related ifdef as that's the only user:

arch/arm/mach-omap2/board-h4.c:238: warning: ?is_gpmc_muxed? defined but not used

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-h4.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 69c0acf..f745cae 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -229,6 +229,8 @@ static u32 get_sysboot_value(void)
 		 OMAP2_SYSBOOT_1_MASK | OMAP2_SYSBOOT_0_MASK));
 }
 
+#if IS_ENABLED(CONFIG_SMC91X)
+
 /* H4-2420's always used muxed mode, H4-2422's always use non-muxed
  *
  * Note: OMAP-GIT doesn't correctly do is_cpu_omap2422 and is_cpu_omap2423
@@ -246,8 +248,6 @@ static u32 is_gpmc_muxed(void)
 		return 0;
 }
 
-#if IS_ENABLED(CONFIG_SMC91X)
-
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs		= 1,
 	.gpio_irq	= 92,
