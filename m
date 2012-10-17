From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:15 +0900
Subject: [PATCH 04/10] ARM: shmobile: kzm9g: enable DMAEngine on SHDI0 and
 SDHI2
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448761-27346-5-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

This patch enables DMAEngine on SHDI0 and SDHI2 for kzm9g.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/board-kzm9g.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-kzm9g.c b/arch/arm/mach-shmobile/board-kzm9g.c
index 1a46422..f63f2ee 100644
--- a/arch/arm/mach-shmobile/board-kzm9g.c
+++ b/arch/arm/mach-shmobile/board-kzm9g.c
@@ -384,6 +384,8 @@ static struct regulator_consumer_supply fixed2v8_power_consumers[] =
 
 /* SDHI */
 static struct sh_mobile_sdhi_info sdhi0_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI0_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI0_RX,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT,
 	.tmio_caps	= MMC_CAP_SD_HIGHSPEED,
 	.tmio_ocr_mask	= MMC_VDD_27_28 | MMC_VDD_28_29,
@@ -424,6 +426,8 @@ static struct platform_device sdhi0_device = {
 
 /* Micro SD */
 static struct sh_mobile_sdhi_info sdhi2_info = {
+	.dma_slave_tx	= SHDMA_SLAVE_SDHI2_TX,
+	.dma_slave_rx	= SHDMA_SLAVE_SDHI2_RX,
 	.tmio_flags	= TMIO_MMC_HAS_IDLE_WAIT |
 			  TMIO_MMC_USE_GPIO_CD |
 			  TMIO_MMC_WRPROTECT_DISABLE,
-- 
1.7.10.4
