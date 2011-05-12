From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 May 2011 10:08:09 +0900
Subject: [PATCH 3/3] tty: Remove to support serial for S5P6442
In-Reply-To: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
References: <1305162489-25499-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1305162489-25499-4-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to removing ARCH_S5P6442, we don't need to support
serial for S5P6442.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/tty/serial/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 80484af..2892f22 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -537,7 +537,7 @@ config SERIAL_S3C6400
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_S5P6442 || CPU_EXYNOS4210)
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210)
 	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210)
 	default y
 	help
-- 
1.7.1
