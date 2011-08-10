From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Aug 2011 09:51:16 +0200
Subject: [PATCH] plat-nomadik: small fixup for gpio.h
Message-ID: <mailman.60.1312962897.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Removing the generic gpio.h broke compilation of the Nomadik
GPIO driver since it implicitly got u32 from it. Explicitly
include <linux/kernel.h> so we get u32 defined.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/plat-nomadik/include/plat/gpio.h |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-nomadik/include/plat/gpio.h
b/arch/arm/plat-nomadik/include/plat/gpio.h
index cf0b78b..b894a53 100644
--- a/arch/arm/plat-nomadik/include/plat/gpio.h
+++ b/arch/arm/plat-nomadik/include/plat/gpio.h
@@ -12,6 +12,8 @@
 #ifndef __ASM_PLAT_GPIO_H
 #define __ASM_PLAT_GPIO_H

+#include <linux/kernel.h>
+
 /*
  * "nmk_gpio" and "NMK_GPIO" stand for "Nomadik GPIO", leaving
  * the "gpio" namespace for generic and cross-machine functions
--=20
1.7.3.2

Thanks,
Linus Walleij
