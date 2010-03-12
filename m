From: chripell@fsfe.org (Christian Pellegrin)
Date: Fri, 12 Mar 2010 08:28:47 +0100
Subject: [PATCH v2] Fix GPIOs banks not being preserved during suspend
In-Reply-To: <cabda6421003112325w23628518tf12f2a7dae7b69ef@mail.gmail.com>
References: <cabda6421003112325w23628518tf12f2a7dae7b69ef@mail.gmail.com>
Message-ID: <1268378927-7898-1-git-send-email-chripell@fsfe.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch corrects the list of registers that must be saved/resumed
during suspend.

Signed-off-by: Christian Pellegrin <chripell@fsfe.org>
---
 arch/arm/mach-s3c2410/include/mach/gpio-core.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-s3c2410/include/mach/gpio-core.h b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
index f8b879a..7c33ecf 100644
--- a/arch/arm/mach-s3c2410/include/mach/gpio-core.h
+++ b/arch/arm/mach-s3c2410/include/mach/gpio-core.h
@@ -24,7 +24,7 @@ static inline struct s3c_gpio_chip *s3c_gpiolib_getchip(unsigned int pin)
 {
 	struct s3c_gpio_chip *chip;
 
-	if (pin > S3C2410_GPG(10))
+	if (pin > S3C_GPIO_END)
 		return NULL;
 
 	chip = &s3c24xx_gpios[pin/32];
-- 
1.5.6.5
