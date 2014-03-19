From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:50 +0100
Subject: [PATCH 53/62] ARM: samsung: fix SAMSUNG_PM_DEBUG Kconfig logic
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-54-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The suspend debug code for Samsung has multiple dependencies
that we should not unconditionally enable. In particular,
we rely on the DEBUG_S3C_UART setting, which in turn depends
on the samsung UART driver.

Signed-off-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Ben Dooks <ben-linux@fluff.org>
---
 arch/arm/plat-samsung/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index 04974db..c72d612 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -428,8 +428,7 @@ comment "Power management"
 
 config SAMSUNG_PM_DEBUG
 	bool "S3C2410 PM Suspend debug"
-	depends on PM
-	select DEBUG_LL
+	depends on PM && DEBUG_KERNEL && DEBUG_S3C_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
 	  Resume code. See <file:Documentation/arm/Samsung-S3C24XX/Suspend.txt>
-- 
1.8.3.2
