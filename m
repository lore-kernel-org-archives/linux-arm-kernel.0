From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:45 +0100
Subject: [PATCH 48/62] ARM: s3c64xx: select power domains only when used
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-49-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The power domain code is only available when CONFIG_PM
is enabled, so we must not select that unconditionally for
s3c64xx. Changing it to 'select PM_GENERIC_DOMAINS if PM'
mirrors what we do on other platforms, and fixes a possible
randconfig build bug.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4721007..6ffcadd 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -764,7 +764,7 @@ config ARCH_S3C64XX
 	select HAVE_TCM
 	select NO_IOPORT
 	select PLAT_SAMSUNG
-	select PM_GENERIC_DOMAINS
+	select PM_GENERIC_DOMAINS if PM
 	select S3C_DEV_NAND
 	select S3C_GPIO_TRACK
 	select SAMSUNG_ATAGS
-- 
1.8.3.2
