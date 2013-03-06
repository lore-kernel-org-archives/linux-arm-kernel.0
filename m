From: pebolle@tiscali.nl (Paul Bolle)
Date: Wed, 06 Mar 2013 11:53:51 +0100
Subject: [PATCH] ARM: drop "select HAVE_SCHED_CLOCK"
Message-ID: <1362567231.16460.175.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol HAVE_SCHED_CLOCK got removed in v3.4, with commit
6905a65879b51d326396e63dfea40861a30bc17f ("ARM: Make the sched_clock
framework mandatory"). Drop the last two select statements for that
symbol too. They're useless now.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Tested with "git grep" only.

 arch/arm/Kconfig             | 1 -
 arch/arm/mach-exynos/Kconfig | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 0c990b7..2530799 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1172,7 +1172,6 @@ config PLAT_VERSATILE
 config ARM_TIMER_SP804
 	bool
 	select CLKSRC_MMIO
-	select HAVE_SCHED_CLOCK
 
 source arch/arm/mm/Kconfig
 
diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 068aeb5..acfdbcf 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -253,7 +253,6 @@ config MACH_UNIVERSAL_C210
 	select EXYNOS4_SETUP_USB_PHY
 	select EXYNOS_DEV_DMA
 	select EXYNOS_DEV_DRM
-	select HAVE_SCHED_CLOCK
 	select S3C_DEV_HSMMC
 	select S3C_DEV_HSMMC2
 	select S3C_DEV_HSMMC3
-- 
1.7.11.7
