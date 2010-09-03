From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Fri,  3 Sep 2010 11:56:52 +0200
Subject: [PATCH 1/7] ARM: specify ZRELADDR for ARCH_TEGRA
In-Reply-To: <20100903095504.GC13643@pengutronix.de>
References: <20100903095504.GC13643@pengutronix.de>
Message-ID: <1283507818-1573-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was missed in commit

	e69edc79 (ARM: Auto calculate ZRELADDR and provide option for exceptions)

Cc: linux-tegra at vger.kernel.org
Cc: Colin Cross <ccross@android.com>
Cc: Erik Gilling <konkers@android.com>
Cc: Olof Johansson <olof@lixom.net>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig                  |    1 +
 arch/arm/mach-tegra/Makefile.boot |    1 -
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a7ed21f..16bc8eb 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1601,6 +1601,7 @@ config ZRELADDR
 		ARCH_ORION5X ||\
 		ARCH_SPEAR3XX ||\
 		ARCH_SPEAR6XX ||\
+		ARCH_TEGRA ||\
 		ARCH_U8500 ||\
 		ARCH_VERSATILE ||\
 		ARCH_W90X900
diff --git a/arch/arm/mach-tegra/Makefile.boot b/arch/arm/mach-tegra/Makefile.boot
index db52d61..6044e12 100644
--- a/arch/arm/mach-tegra/Makefile.boot
+++ b/arch/arm/mach-tegra/Makefile.boot
@@ -1,3 +1,2 @@
-zreladdr-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00008000
 params_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00000100
 initrd_phys-$(CONFIG_ARCH_TEGRA_2x_SOC)	:= 0x00800000
-- 
1.7.1
