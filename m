From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 14 Feb 2011 17:23:07 +0900
Subject: [PATCH 11/11] tty: Change dependency of ARCH_EXYNOS4
In-Reply-To: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
References: <1297671787-10571-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1297671787-10571-12-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch changes dependency of ARCH_EXYNOS4 from ARCH_S5PV310
according to the change of ARCH name, EXYNOS4.

Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/tty/serial/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 2b83346..8f144d0 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -537,8 +537,8 @@ config SERIAL_S3C6400
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442 || CPU_S5PV310)
-	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_S5PV310)
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442 || CPU_EXYNOS4210)
+	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210)
 	default y
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
-- 
1.7.1
