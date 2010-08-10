From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Tue, 10 Aug 2010 22:14:12 +0200
Subject: [PATCH] ARM: fix syntax error in main Kconfig file
In-Reply-To: <20100810200718.GA26031@pengutronix.de>
References: <20100810200718.GA26031@pengutronix.de>
Message-ID: <1281471252-31424-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:

	scripts/kconfig/mconf arch/arm/Kconfig
	arch/arm/Kconfig:1187: invalid option
	make[1]: *** [menuconfig] Error 1
	make: *** [menuconfig] Error 2

which was introduced by

	1cea732 ([ARM] tegra: SMP support)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Cc: Tanmay Upadhyay <tanmay.upadhyay@einfochips.com>
Cc: xsecute at googlemail.com
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Colin Cross <ccross@android.com>
---
KernelVersion: v2.6.35-3374-g1cea732
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 232f0c7..952ded5 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1184,7 +1184,7 @@ config LOCAL_TIMERS
 		REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
 		ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
 	default y
-	select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
+	select HAVE_ARM_TWD if ARCH_REALVIEW || ARCH_VEXPRESS || ARCH_OMAP4 || \\
 		ARCH_U8500 || ARCH_TEGRA
 	help
 	  Enable support for local timers on SMP platforms, rather then the
-- 
1.7.1
