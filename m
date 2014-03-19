From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:47 +0100
Subject: [PATCH 50/62] ARM: s5pv210: enable IDE support in MACH_TORBRECK
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-51-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Building MACH_TORBRECK by itself results in a build error
because we try to reference the s3c_device_cfcon definition
that is hidden inside CONFIG_SAMSUNG_DEV_IDE. This changes
the Kconfig logic to ensure that option is enabled when we
need it.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/mach-s5pv210/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s5pv210/Kconfig b/arch/arm/mach-s5pv210/Kconfig
index caaedaf..8c3abe5 100644
--- a/arch/arm/mach-s5pv210/Kconfig
+++ b/arch/arm/mach-s5pv210/Kconfig
@@ -189,6 +189,7 @@ config MACH_TORBRECK
 	select S5PV210_SETUP_I2C1
 	select S5PV210_SETUP_I2C2
 	select S5PV210_SETUP_SDHCI
+	select SAMSUNG_DEV_IDE
 	help
 	  Machine support for aESOP Torbreck
 
-- 
1.8.3.2
