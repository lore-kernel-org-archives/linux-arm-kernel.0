From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Thu, 04 Aug 2016 12:08:11 +0200
Subject: [PATCH] ARM: S3C24XX: Add missing DMA device for Mini2440 board
Message-ID: <1470305291-15054-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Addition of s3c2440_device_dma was missed during conversion
from the Samsung legacy to the regular DMa API.
Add it so any devices using DMA, e.g I2S controller can
work properly.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/mach-s3c24xx/mach-mini2440.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-s3c24xx/mach-mini2440.c b/arch/arm/mach-s3c24xx/mach-mini2440.c
index a852168..bbf4132 100644
--- a/arch/arm/mach-s3c24xx/mach-mini2440.c
+++ b/arch/arm/mach-s3c24xx/mach-mini2440.c
@@ -516,6 +516,7 @@ static struct platform_device *mini2440_devices[] __initdata = {
 	&mini2440_button_device,
 	&s3c_device_nand,
 	&s3c_device_sdi,
+	&s3c2440_device_dma,
 	&s3c_device_iis,
 	&uda1340_codec,
 	&mini2440_audio,
-- 
1.9.1
