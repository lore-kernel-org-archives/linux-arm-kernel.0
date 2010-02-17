From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 17 Feb 2010 18:19:30 +0000
Subject: [PATCH 2/3] ARM: S3C64XX: Add initial support for board specific IRQs
In-Reply-To: <1266430771-6037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1266430771-6037-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Message-ID: <1266430771-6037-2-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Follow the scheme used for IRQs. By default 16 GPIOs are allocated
for board use.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/mach-s3c6400/include/mach/gpio.h |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c6400/include/mach/gpio.h b/arch/arm/mach-s3c6400/include/mach/gpio.h
index e8e35e8..0d46e99 100644
--- a/arch/arm/mach-s3c6400/include/mach/gpio.h
+++ b/arch/arm/mach-s3c6400/include/mach/gpio.h
@@ -91,6 +91,10 @@ enum s3c_gpio_number {
 #define S3C_GPIO_END		S3C64XX_GPIO_END
 
 /* define the number of gpios we need to the one after the GPQ() range */
-#define ARCH_NR_GPIOS	(S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
+#define GPIO_BOARD_START (S3C64XX_GPQ(S3C64XX_GPIO_Q_NR) + 1)
+
+#define BOARD_NR_GPIOS 16
+
+#define ARCH_NR_GPIOS	(GPIO_BOARD_START + BOARD_NR_GPIOS)
 
 #include <asm-generic/gpio.h>
-- 
1.6.6.1
