From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 29 Oct 2014 13:59:54 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a73a4: Remove empty
 r8a73a4_add_dt_devices
In-Reply-To: <cover.1414557047.git.horms+renesas@verge.net.au>
References: <cover.1414557047.git.horms+renesas@verge.net.au>
Message-ID: <fd3edcbe9f7bf24b13cadca7616f8e10bbe7e2b3.1414557047.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a73a4_add_dt_devices() no longer enables any devices
so remove it.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 1 -
 arch/arm/mach-shmobile/r8a73a4.h                 | 1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c           | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index a6503d8..7c7c6f7 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -48,7 +48,6 @@ static void __init ape6evm_add_standard_devices(void)
 	clk_put(parent);
 	clk_put(mp);
 
-	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
diff --git a/arch/arm/mach-shmobile/r8a73a4.h b/arch/arm/mach-shmobile/r8a73a4.h
index 5fafd6f..70dcd84 100644
--- a/arch/arm/mach-shmobile/r8a73a4.h
+++ b/arch/arm/mach-shmobile/r8a73a4.h
@@ -11,7 +11,6 @@ enum {
 };
 
 void r8a73a4_add_standard_devices(void);
-void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
 
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 3b7efc0..179f28a 100644
--- a/arch/arm/mach-shmobile/setup-r8a73a4.c
+++ b/arch/arm/mach-shmobile/setup-r8a73a4.c
@@ -187,10 +187,6 @@ static struct resource cmt1_resources[] = {
 					  &cmt##idx##_platform_data,	\
 					  sizeof(struct sh_timer_config))
 
-void __init r8a73a4_add_dt_devices(void)
-{
-}
-
 /* DMA */
 static const struct sh_dmae_slave_config dma_slaves[] = {
 	{
-- 
2.1.1
