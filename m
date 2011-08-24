From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 24 Aug 2011 22:25:52 +0900
Subject: [PATCH 5/5] tty: Add support serial for EXYNOS4212 SoC
In-Reply-To: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
References: <1314192352-14911-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1314192352-14911-6-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

According to add support EXYNOS4212 SoC, we need to enable
SERIAL_S5PV210 on EXYNOS4212.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 drivers/tty/serial/Kconfig |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 4dcb37b..bff6943 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -522,8 +522,8 @@ config SERIAL_S3C6400
 
 config SERIAL_S5PV210
 	tristate "Samsung S5PV210 Serial port support"
-	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210)
-	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210)
+	depends on SERIAL_SAMSUNG && (CPU_S5PV210 || CPU_EXYNOS4210 || SOC_EXYNOS4212)
+	select SERIAL_SAMSUNG_UARTS_4 if (CPU_S5PV210 || CPU_EXYNOS4210 || SOC_EXYNOS4212)
 	default y
 	help
 	  Serial port support for Samsung's S5P Family of SoC's
-- 
1.7.1
