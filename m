From: pebolle@tiscali.nl (Paul Bolle)
Date: Fri, 08 Mar 2013 13:06:37 +0100
Subject: [PATCH] ARM: OMAP: fix typo "CONFIG_SMC91x_MODULE"
Message-ID: <1362744397.5994.58.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There's a (rather subtle) typo in "CONFIG_SMC91x_MODULE". Fix it once
and for all by using IS_ENABLED(), which is designed to avoid issues
like this.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested! And this needs build- and runtime testing, especially for the
MODULE case!

 arch/arm/mach-omap2/board-2430sdp.c | 2 +-
 arch/arm/mach-omap2/board-h4.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index a3e0aaa..cb0596b 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -166,7 +166,7 @@ static void __init sdp2430_display_init(void)
 	omap_display_init(&sdp2430_dss_data);
 }
 
-#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
+#if IS_ENABLED(CONFIG_SMC91X)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs		= 5,
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index 812c829..5b4ec51 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -246,7 +246,7 @@ static u32 is_gpmc_muxed(void)
 		return 0;
 }
 
-#if defined(CONFIG_SMC91X) || defined(CONFIG_SMC91x_MODULE)
+#if IS_ENABLED(CONFIG_SMC91X)
 
 static struct omap_smc91x_platform_data board_smc91x_data = {
 	.cs		= 1,
-- 
1.7.11.7
