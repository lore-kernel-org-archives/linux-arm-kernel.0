From: linus.walleij@stericsson.com (Linus Walleij)
Date: Wed, 19 Dec 2012 09:57:13 +0100
Subject: [PATCH] ARM: ux500: bump arch nr of GPIOs
Message-ID: <1355907433-18656-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Set the number of GPIOs for Ux500 to 392. Reasoning:

- Internal pinctrl "Nomadik" SoC: 288 GPIOs
- Then each Ux500 system has one or two GPIO expanders at
  maximum 24 GPIOs each:
  TC35892 expander: 24 GPIOs
  STMPE1601 or 1801 Expander: 24 GPIOs
- Then AB8500/AB8505/AB8540: 56 GPIOs

Sum: maximum 392 GPIOs - no more no less.

Acked-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 2277f95..32a3531 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1630,7 +1630,7 @@ config LOCAL_TIMERS
 config ARCH_NR_GPIO
 	int
 	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
-	default 355 if ARCH_U8500
+	default 392 if ARCH_U8500
 	default 264 if MACH_H4700
 	default 512 if SOC_OMAP5
 	default 288 if ARCH_VT8500
-- 
1.7.11.3
