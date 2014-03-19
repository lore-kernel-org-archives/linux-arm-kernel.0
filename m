From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 19 Mar 2014 14:03:20 +0100
Subject: [PATCH 07/16] PWM: atmel: allow building for AVR32
In-Reply-To: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1395234209-15546-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1395234209-15546-8-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Atmel PWM IP can be found on avr32 chips. This allows selecting and building
the driver on avr32.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 drivers/pwm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 22f2f2857b82..892dd1ab4134 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -43,7 +43,7 @@ config PWM_AB8500
 
 config PWM_ATMEL
 	tristate "Atmel PWM support"
-	depends on ARCH_AT91
+	depends on ARCH_AT91 || AVR32
 	help
 	  Generic PWM framework driver for Atmel SoC.
 
-- 
1.8.3.2
