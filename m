From: ch.naveen@samsung.com (Naveen Krishna Chatradhi)
Date: Tue, 02 Sep 2014 21:05:42 +0530
Subject: [PATCH v2 6/7] tty/serial: samsung: enable usage for 64-bit Exynos
 platforms
In-Reply-To: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
References: <1409672143-8574-1-git-send-email-ch.naveen@samsung.com>
Message-ID: <1409672143-8574-7-git-send-email-ch.naveen@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow Samsung serial driver to be usable on Exynos 64-bit SoC based
platforms.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 26cec64..3383744 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -220,7 +220,7 @@ config SERIAL_CLPS711X_CONSOLE
 
 config SERIAL_SAMSUNG
 	tristate "Samsung SoC serial support"
-	depends on PLAT_SAMSUNG
+	depends on PLAT_SAMSUNG || ARCH_EXYNOS
 	select SERIAL_CORE
 	help
 	  Support for the on-chip UARTs on the Samsung S3C24XX series CPUs,
-- 
1.7.9.5
