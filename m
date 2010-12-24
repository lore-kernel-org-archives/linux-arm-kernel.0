From: sw.youn@samsung.com (Seungwhan Youn)
Date: Fri, 24 Dec 2010 15:46:58 +0900
Subject: [PATCH 3/4] ASoC: SAMSUNG: Modify to indepedant depends on
	configuration
In-Reply-To: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
References: <1293171965-24416-1-git-send-email-sw.youn@samsung.com>
Message-ID: <1293173218-3487-1-git-send-email-sw.youn@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch modify to support ASoC Samsung which is selected HAVE_ASOC_SAMSUNG
from platform configuration automatically. After this, ASoC has not consider
which arch(or plat) adds to support audio driver.

Signed-off-by: Seungwhan Youn <sw.youn@samsung.com>
---
 sound/soc/samsung/Kconfig |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 11ff4ad..90fe869 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -1,6 +1,5 @@
 config ASOC_SAMSUNG
 	tristate "ASoC support for Samsung"
-	depends on ARCH_S3C2410 || ARCH_S3C64XX || ARCH_S5PC100 || ARCH_S5PV210 || ARCH_S5P64X0 || ARCH_S5P6442 || ARCH_S5PV310
 	select S3C64XX_DMA if ARCH_S3C64XX
 	select S3C2410_DMA if ARCH_S3C2410
 	help
-- 
1.6.2.5
