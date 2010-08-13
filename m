From: marek.vasut@gmail.com (Marek Vasut)
Date: Fri, 13 Aug 2010 06:32:33 +0200
Subject: [PATCH 02/13] PXA: Vpac270: Fix gpio_power for MMC
In-Reply-To: <1281673964-2119-1-git-send-email-marek.vasut@gmail.com>
References: <1281673964-2119-1-git-send-email-marek.vasut@gmail.com>
Message-ID: <1281673964-2119-2-git-send-email-marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GPIO 0 is valid, yet this platform doesn't have any power GPIO for MMC.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/vpac270.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-pxa/vpac270.c b/arch/arm/mach-pxa/vpac270.c
index c9b747c..37d6173 100644
--- a/arch/arm/mach-pxa/vpac270.c
+++ b/arch/arm/mach-pxa/vpac270.c
@@ -240,6 +240,7 @@ static void __init vpac270_onenand_init(void) {}
 #if defined(CONFIG_MMC_PXA) || defined(CONFIG_MMC_PXA_MODULE)
 static struct pxamci_platform_data vpac270_mci_platform_data = {
 	.ocr_mask		= MMC_VDD_32_33 | MMC_VDD_33_34,
+	.gpio_power		= -1,
 	.gpio_card_detect	= GPIO53_VPAC270_SD_DETECT_N,
 	.gpio_card_ro		= GPIO52_VPAC270_SD_READONLY,
 	.detect_delay_ms	= 200,
-- 
1.7.1
