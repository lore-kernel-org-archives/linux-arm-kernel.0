From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Mon, 25 Jul 2011 17:47:53 +0200
Subject: [PATCH 1/2] ARM: tegra: only select MACH_HAS_SND_SOC_TEGRA_WM8903 if
	SOUND_SOC
Message-ID: <1311608874-31863-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This fixes:
	warning: (MACH_HARMONY && MACH_KAEN && MACH_SEABOARD) selects MACH_HAS_SND_SOC_TEGRA_WM8903 which has unmet direct dependencies (SOUND && !M68K && SND && SND_SOC)

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/mach-tegra/Kconfig |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-tegra/Kconfig b/arch/arm/mach-tegra/Kconfig
index 5ec1846..33acbd9 100644
--- a/arch/arm/mach-tegra/Kconfig
+++ b/arch/arm/mach-tegra/Kconfig
@@ -27,14 +27,14 @@ comment "Tegra board type"
 
 config MACH_HARMONY
        bool "Harmony board"
-       select MACH_HAS_SND_SOC_TEGRA_WM8903
+       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC
        help
          Support for nVidia Harmony development platform
 
 config MACH_KAEN
        bool "Kaen board"
        select MACH_SEABOARD
-       select MACH_HAS_SND_SOC_TEGRA_WM8903
+       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC
        help
          Support for the Kaen version of Seaboard
 
@@ -45,7 +45,7 @@ config MACH_PAZ00
 
 config MACH_SEABOARD
        bool "Seaboard board"
-       select MACH_HAS_SND_SOC_TEGRA_WM8903
+       select MACH_HAS_SND_SOC_TEGRA_WM8903 if SOUND_SOC
        help
          Support for nVidia Seaboard development platform. It will
 	 also be included for some of the derivative boards that
-- 
1.7.5.4
