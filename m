From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  7 Jul 2014 09:54:39 +0200
Subject: [PATCH v2 14/30] ARM: shmobile: r8a73a4: Remove empty
 r8a73a4_add_dt_devices
In-Reply-To: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
References: <1404719695-1634-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404719695-1634-15-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

r8a73a4_add_dt_devices() no longer enables any devices
so remove it.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

---
v2
* First post
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 1 -
 arch/arm/mach-shmobile/r8a73a4.h                 | 1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c           | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 2f7723e..f0aef6dc 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -48,7 +48,6 @@ static void __init ape6evm_add_standard_devices(void)
 	clk_put(parent);
 	clk_put(mp);
 
-	r8a73a4_add_dt_devices();
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 	platform_device_register_simple("cpufreq-cpu0", -1, NULL, 0);
 }
diff --git a/arch/arm/mach-shmobile/r8a73a4.h b/arch/arm/mach-shmobile/r8a73a4.h
index ce8bdd1..7ced9ab 100644
--- a/arch/arm/mach-shmobile/r8a73a4.h
+++ b/arch/arm/mach-shmobile/r8a73a4.h
@@ -11,7 +11,6 @@ enum {
 };
 
 void r8a73a4_add_standard_devices(void);
-void r8a73a4_add_dt_devices(void);
 void r8a73a4_clock_init(void);
 void r8a73a4_pinmux_init(void);
 void r8a73a4_init_early(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a73a4.c b/arch/arm/mach-shmobile/setup-r8a73a4.c
index 10e3f14..372cce4 100644
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
2.0.0.rc2
