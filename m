From: gwenhael.goavec-merou@armadeus.com (Gwenhael Goavec-Merou)
Date: Sun, 13 Jan 2013 16:56:42 +0100
Subject: [PATCH] ARM: imx: platform-imx-fb: modifies platform device name
Message-ID: <1358092603-13480-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gwenhael Goavec-Merou <gwe@trabucayre.com>

Framebuffer platform device is now identified by a device id (imx1-fb or
imx21-fb) instead of by driver name (imx-fb).

Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
---
 arch/arm/mach-imx/devices/platform-imx-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/devices/platform-imx-fb.c b/arch/arm/mach-imx/devices/platform-imx-fb.c
index 10b0ed3..25a47c6 100644
--- a/arch/arm/mach-imx/devices/platform-imx-fb.c
+++ b/arch/arm/mach-imx/devices/platform-imx-fb.c
@@ -54,7 +54,7 @@ struct platform_device *__init imx_add_imx_fb(
 			.flags = IORESOURCE_IRQ,
 		},
 	};
-	return imx_add_platform_device_dmamask("imx-fb", 0,
+	return imx_add_platform_device_dmamask(data->devid, 0,
 			res, ARRAY_SIZE(res),
 			pdata, sizeof(*pdata), DMA_BIT_MASK(32));
 }
-- 
1.7.12.4
