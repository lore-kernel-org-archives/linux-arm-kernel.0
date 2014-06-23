From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 23 Jun 2014 11:26:31 +0900
Subject: [PATCH 18/24] ARM: shmobile: r8a7779: Remove unused
 r8a7779_init_delay()
In-Reply-To: <cover.1403487423.git.horms+renesas@verge.net.au>
References: <cover.1403487423.git.horms+renesas@verge.net.au>
Message-ID: <daab540e3a2afeb8c087a67dfaee5aa50a29e844.1403487423.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the now unused r8a7779_init_delay() function.

Based on work for the r8a7740 SoC by Magnus Damm.

Cc: Magnus Damm <damm+renesas@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/include/mach/r8a7779.h | 1 -
 arch/arm/mach-shmobile/setup-r8a7779.c        | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/include/mach/r8a7779.h b/arch/arm/mach-shmobile/include/mach/r8a7779.h
index 5ef0bad..5415c71 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -10,7 +10,6 @@ enum {
 	HPBDMA_SLAVE_SDHI0_RX,
 };
 
-extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_extpin_dt(int irlm);
 extern void r8a7779_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 706832f..f96a304 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -737,11 +737,6 @@ void __init r8a7779_init_irq_dt(void)
 	__raw_writel(0x003fee3f, INT2SMSKCR4);
 }
 
-void __init r8a7779_init_delay(void)
-{
-	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
-}
-
 void __init r8a7779_add_standard_devices_dt(void)
 {
 	platform_add_devices(r8a7779_devices_dt,
-- 
2.0.0.rc2
