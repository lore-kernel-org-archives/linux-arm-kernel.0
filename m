From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 13:43:01 +0900
Subject: [PATCH 4/4] ARM: shmobile: r8a7779: Remove unused r8a7779_init_delay()
In-Reply-To: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
References: <1400215381-7027-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1400215381-7027-5-git-send-email-horms+renesas@verge.net.au>
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
index 757b903..e443c54 100644
--- a/arch/arm/mach-shmobile/include/mach/r8a7779.h
+++ b/arch/arm/mach-shmobile/include/mach/r8a7779.h
@@ -21,7 +21,6 @@ static inline struct rcar_sysc_ch *to_r8a7779_ch(struct generic_pm_domain *d)
 	return &container_of(d, struct r8a7779_pm_domain, genpd)->ch;
 }
 
-extern void r8a7779_init_delay(void);
 extern void r8a7779_init_irq_extpin(int irlm);
 extern void r8a7779_init_irq_extpin_dt(int irlm);
 extern void r8a7779_init_irq_dt(void);
diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 3cad080..a57a454 100644
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
1.8.5.2
