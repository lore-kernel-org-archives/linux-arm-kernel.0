From: linus.walleij@stericsson.com (Linus Walleij)
Date: Fri, 1 Feb 2013 09:52:05 +0100
Subject: [PATCH] ARM: nomadik: fix OF compilation regression
Message-ID: <1359708725-21978-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

The Nomadik Device Tree patch series accidentally
selected OF instead of USE_OF which led to problems
during compile:

arch/arm/kernel/devtree.c: In function 'arm_dt_memblock_reserve':
/home/elinwal/linux-arm-soc/arch/arm/kernel/devtree.c:43:7: error: 'initial_boot_params' undeclared (first use in this function)
(etc).

This fixes it up by selecting USE_OF instead.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC guys: this applies to your nomadik/dt branch.
Please apply it directly.
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index bef46ed..42ee64e 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -904,7 +904,7 @@ config ARCH_NOMADIK
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
 	select MIGHT_HAVE_CACHE_L2X0
-	select OF
+	select USE_OF
 	select PINCTRL
 	select PINCTRL_STN8815
 	select SPARSE_IRQ
-- 
1.7.11.3
