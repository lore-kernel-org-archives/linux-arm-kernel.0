From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 30 Jun 2014 22:20:05 +0300
Subject: [PATCH 2/6] ARM: s3c24xx: add dma_coherent_mask for DMA devices
In-Reply-To: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
References: <1404156009-3919-1-git-send-email-anarsoul@gmail.com>
Message-ID: <1404156009-3919-2-git-send-email-anarsoul@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Otherwise dma_alloc_coherent() fails.

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 arch/arm/mach-s3c24xx/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-s3c24xx/common.c b/arch/arm/mach-s3c24xx/common.c
index c0763b8..2fa0a99 100644
--- a/arch/arm/mach-s3c24xx/common.c
+++ b/arch/arm/mach-s3c24xx/common.c
@@ -358,6 +358,7 @@ struct platform_device s3c2410_device_dma = {
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
 		.platform_data	= &s3c2410_dma_platdata,
+		.coherent_dma_mask = ~0,
 	},
 };
 #endif
@@ -455,6 +456,7 @@ struct platform_device s3c2440_device_dma = {
 	.resource	= s3c2410_dma_resource,
 	.dev	= {
 		.platform_data	= &s3c2440_dma_platdata,
+		.coherent_dma_mask = ~0,
 	},
 };
 #endif
-- 
2.0.0
