From: levex@linux.com (Levente Kurusa)
Date: Thu, 19 Dec 2013 16:03:17 +0100
Subject: [PATCH 06/38] arm: mach-s3c64: add missing put_device call
In-Reply-To: <1387465429-3568-2-git-send-email-levex@linux.com>
References: <1387465429-3568-2-git-send-email-levex@linux.com>
Message-ID: <1387465429-3568-7-git-send-email-levex@linux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is required so that we give up the last reference to the device.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 arch/arm/mach-s3c64xx/dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c64xx/dma.c b/arch/arm/mach-s3c64xx/dma.c
index 7e22c21..090852d 100644
--- a/arch/arm/mach-s3c64xx/dma.c
+++ b/arch/arm/mach-s3c64xx/dma.c
@@ -663,6 +663,7 @@ static int s3c64xx_dma_init1(int chno, enum dma_ch chbase,
 	err = device_register(&dmac->dev);
 	if (err) {
 		printk(KERN_ERR "%s: failed to register device\n", __func__);
+		put_device(&dmac->dev);
 		goto err_alloc;
 	}
 
-- 
1.8.3.1
