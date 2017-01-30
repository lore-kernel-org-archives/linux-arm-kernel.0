From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 30 Jan 2017 20:36:34 +0100
Subject: [PATCH 3/4] ARM: gemini: select gemini poweroff
In-Reply-To: <20170130193635.18644-1-linus.walleij@linaro.org>
References: <20170130193635.18644-1-linus.walleij@linaro.org>
Message-ID: <20170130193635.18644-3-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's especially annoying if the system cannot be properly
powered down so select the poweroff driver from the Kconfig.

Cc: Janos Laube <janos.dev@gmail.com>
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Sebastian: this patch is just for context.
I will funnel the ARM parts through the ARM SoC tree.
---
 arch/arm/mach-gemini/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-gemini/Kconfig b/arch/arm/mach-gemini/Kconfig
index 91ea52ccf13c..4b5c059d602b 100644
--- a/arch/arm/mach-gemini/Kconfig
+++ b/arch/arm/mach-gemini/Kconfig
@@ -7,6 +7,7 @@ menuconfig ARCH_GEMINI
 	select GPIOLIB
 	select MIGHT_HAVE_PCI
 	select POWER_RESET
+	select POWER_RESET_GEMINI_POWEROFF
 	select POWER_RESET_SYSCON
 	select SERIAL_OF_PLATFORM
 	help
-- 
2.9.3
