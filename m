From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:20:07 +0300
Subject: [PATCH 4/6] ARM: s3c24xx: DMA: SDI channel requires handshake
In-Reply-To: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
References: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1404156009-3919-4-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At least Windows Mobile driver enables it.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c24xx/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index 2fa0a99..e505114 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -322,7 +322,7 @@ static struct resource s3c2410_dma_resource[] = {
 static struct s3c24xx_dma_channel s3c2410_dma_channels[DMACH_MAX] = {
 	[DMACH_XD0] = { S3C24XX_DMA_AHB, true, S3C24XX_DMA_CHANREQ(0, 0), },
 	[DMACH_XD1] = { S3C24XX_DMA_AHB, true, S3C24XX_DMA_CHANREQ(0, 1), },
-	[DMACH_SDI] = { S3C24XX_DMA_APB, false, S3C24XX_DMA_CHANREQ(2, 0) |
+	[DMACH_SDI] = { S3C24XX_DMA_APB, true, S3C24XX_DMA_CHANREQ(2, 0) |
 						S3C24XX_DMA_CHANREQ(2, 2) |
 						S3C24XX_DMA_CHANREQ(1, 3),
 	},
-- 
2.0.0
