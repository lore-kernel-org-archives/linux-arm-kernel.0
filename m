From: eric.y.miao@gmail.com (Eric Miao)
Date: Mon, 14 Jun 2010 18:19:30 +0800
Subject: [PATCH] [ARM] pxa/corgi: fix MMC/SD card detection failure
Message-ID: <1276510770-27748-1-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Andrea Adami <andrea.adami@gmail.com>
Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/corgi.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/corgi.c b/arch/arm/mach-pxa/corgi.c
index 3d1dcb9..51ffa6a 100644
--- a/arch/arm/mach-pxa/corgi.c
+++ b/arch/arm/mach-pxa/corgi.c
@@ -446,7 +446,7 @@ static struct platform_device corgiled_device = {
 static struct pxamci_platform_data corgi_mci_platform_data = {
 	.detect_delay_ms	= 250,
 	.ocr_mask		= MMC_VDD_32_33|MMC_VDD_33_34,
-	.gpio_card_detect	= -1,
+	.gpio_card_detect	= CORGI_GPIO_nSD_DETECT,
 	.gpio_card_ro		= CORGI_GPIO_nSD_WP,
 	.gpio_power		= CORGI_GPIO_SD_PWR,
 };
-- 
1.7.1.251.g92a7
