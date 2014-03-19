From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:52 +0100
Subject: [PATCH 55/62] ARM: samsung: select CRC32 for SAMSUNG_PM_CHECK
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-56-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Samsung pm_check code uses the crc32 library code, which can
be built as a loadable module, in which case we get a link error
building the kernel.

A better solution is to use 'select CRC32', which is what all
other users of this code do, as it ensures it is always built-in.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index c72d612..98f223c 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -445,7 +445,8 @@ config S3C_PM_DEBUG_LED_SMDK
 
 config SAMSUNG_PM_CHECK
 	bool "S3C2410 PM Suspend Memory CRC"
-	depends on PM && CRC32
+	depends on PM
+	select CRC32
 	help
 	  Enable the PM code's memory area checksum over sleep. This option
 	  will generate CRCs of all blocks of memory, and store them before
-- 
1.8.3.2
