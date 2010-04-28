From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Wed, 28 Apr 2010 11:43:00 -0400
Subject: [PATCH] [ARM] mmp: configure gpio pins from 128 to 192
Message-ID: <mailman.327.1272457188.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In mmp2, 6 banks of GPIO registers are supported. So we can support 192
GPIO pins at most.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/gpio.h
b/arch/arm/mach-mmp/include/mach/gpio.h
index ab26d13..ee8b02e 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -10,7 +10,7 @@
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 #define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))

-#define NR_BUILTIN_GPIO	(128)
+#define NR_BUILTIN_GPIO	(192)

 #define gpio_to_bank(gpio)	((gpio) >> 5)
 #define gpio_to_irq(gpio)	(IRQ_GPIO_START + (gpio))
-- 
1.5.6.5
