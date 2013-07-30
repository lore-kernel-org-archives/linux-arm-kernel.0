From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 30 Jul 2013 16:55:43 +0530
Subject: [PATCH v2 5/8] ARM: DRA7: Resue the clocksource, clockevent support
In-Reply-To: <1375183546-12758-1-git-send-email-rnayak@ti.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
Message-ID: <1375183546-12758-6-git-send-email-rnayak@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: R Sricharan <r.sricharan@ti.com>

All of OMAP5 timer support for clocksource and clockevent is completely
reused across DRA7.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 arch/arm/mach-omap2/timer.c |    3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 3eed000..fc6ec23 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -132,7 +132,7 @@ config SOC_HAS_OMAP2_SDRC
 
 config SOC_HAS_REALTIME_COUNTER
 	bool "Real time free running counter"
-	depends on SOC_OMAP5
+	depends on SOC_OMAP5 || SOC_DRA7XX
 	default y
 
 comment "OMAP Core Type"
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index b37e1fc..1e77f11 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -594,7 +594,8 @@ OMAP_SYS_GP_TIMER_INIT(3, 2, "timer_sys_ck", NULL,
 		       1, "timer_sys_ck", "ti,timer-alwon");
 #endif
 
-#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
+#if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
+	defined(CONFIG_SOC_DRA7XX)
 static OMAP_SYS_32K_TIMER_INIT(4, 1, "timer_32k_ck", "ti,timer-alwon",
 			       2, "sys_clkin_ck", NULL);
 #endif
-- 
1.7.9.5
