From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Sat,  1 Mar 2014 09:33:18 +0100
Subject: [PATCH v2 2/5] watchdog: orion: prepare new Dove DT Kconfig variable
In-Reply-To: <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1393662801-17950-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1393662801-17950-2-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

DT-enabled Dove will move over from ARCH_DOVE in mach-dove to MACH_DOVE in
mach-mvebu. As non-DT ARCH_DOVE will stay to rot for a while, add a new
DT-only MACH_DOVE Kconfig.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Acked-by: Wim Van Sebroeck <wim@iguana.be>
---
Wim, Mark Brown requested to take the corresponding ASoC patch through
his tree. Therefore, I have split the former patch into individual subsystem
patches.

Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Gregory Clement <gregory.clement@free-electrons.com>
Cc: linux-watchdog at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/watchdog/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 79d25894343a..5659c62a175c 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -292,7 +292,7 @@ config DAVINCI_WATCHDOG
 
 config ORION_WATCHDOG
 	tristate "Orion watchdog"
-	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE
+	depends on ARCH_ORION5X || ARCH_KIRKWOOD || ARCH_DOVE || MACH_DOVE
 	select WATCHDOG_CORE
 	help
 	  Say Y here if to include support for the watchdog timer
-- 
1.8.5.3
