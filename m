From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Mar 2017 00:28:18 +0100
Subject: [PATCH 6/6] ARM: gemini: select the right GPIO block
In-Reply-To: <20170312232818.26304-1-linus.walleij@linaro.org>
References: <20170312232818.26304-1-linus.walleij@linaro.org>
Message-ID: <20170312232818.26304-6-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to select the GPIO_FTGPIO010 symbol for the generic
Faraday FTGPIO010 driver, not the old driver.

Cc: Jonas Jensen <jonas.jensen@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-gemini/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 2dd8bc720089..eaae82637da3 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -4,7 +4,7 @@ menuconfig ARCH_GEMINI
 	select ARM_APPENDED_DTB # Old Redboot bootloaders deployed
 	select FARADAY_FTINTC010
 	select FTTMR010_TIMER
-	select GPIO_GEMINI
+	select GPIO_FTGPIO010
 	select GPIOLIB
 	select POWER_RESET
 	select POWER_RESET_GEMINI_POWEROFF
-- 
2.9.3
