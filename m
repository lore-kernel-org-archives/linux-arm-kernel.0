From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon,  7 Feb 2011 02:51:54 +0100
Subject: [PATCH 02/09] ARM: s3c2440: gta02: Register PCM device
In-Reply-To: <1297043521-21903-1-git-send-email-lars@metafoo.de>
References: <1297043521-21903-1-git-send-email-lars@metafoo.de>
Message-ID: <1297043521-21903-2-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ASoC multi-component patch introduced a new pcm platform device, which needs
to be registered by board files in order for sound to work.
This patch does this for the gta02 board.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/arm/mach-s3c2440/mach-gta02.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s3c2440/mach-gta02.c b/arch/arm/mach-s3c2440/mach-gta02.c
index 9f2c14e..e83062b 100644
--- a/arch/arm/mach-s3c2440/mach-gta02.c
+++ b/arch/arm/mach-s3c2440/mach-gta02.c
@@ -509,6 +509,7 @@ static struct platform_device *gta02_devices[] __initdata = {
 	&gta02_nor_flash,
 	&s3c24xx_pwm_device,
 	&s3c_device_iis,
+	&samsung_asoc_dma,
 	&s3c_device_i2c0,
 };
 
-- 
1.7.2.3
