From: tom.leiming@gmail.com (Ming Lei)
Date: Sat, 11 Feb 2012 16:31:25 +0800
Subject: [PATCH] arm: omap4: allow disabling MPU local timer if 32K timer is
 enabled
Message-ID: <1328949085-4452-1-git-send-email-tom.leiming@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With 32K gp timer, tick can be driven and system can run well, so
allow MPU local timer to be disabled if someone requires it, otherwise
MPU local timer is always chosen as the default clock_event_device.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index d965da4..12cd602 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -46,7 +46,7 @@ config ARCH_OMAP4
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
-	select LOCAL_TIMERS if SMP
+	select LOCAL_TIMERS if (SMP && !OMAP_32K_TIMER)
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
-- 
1.7.9
