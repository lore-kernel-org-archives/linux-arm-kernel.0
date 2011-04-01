From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  1 Apr 2011 10:39:27 +0800
Subject: [PATCH 8/9] ARM: mmp: align NR_BUILTIN_GPIO with gpio interrupt number
In-Reply-To: <1301625568-16583-7-git-send-email-haojian.zhuang@marvell.com>
References: <040101>
	<1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-7-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1301625568-16583-8-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to mismatch between NR_BUILTIN_GPIO and gpio interrupt number.

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-mmp/include/mach/gpio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/include/mach/gpio.h b/arch/arm/mach-mmp/include/mach/gpio.h
index ee8b02e..7bfb827 100644
--- a/arch/arm/mach-mmp/include/mach/gpio.h
+++ b/arch/arm/mach-mmp/include/mach/gpio.h
@@ -10,7 +10,7 @@
 #define BANK_OFF(n)	(((n) < 3) ? (n) << 2 : 0x100 + (((n) - 3) << 2))
 #define GPIO_REG(x)	(*((volatile u32 *)(GPIO_REGS_VIRT + (x))))
 
-#define NR_BUILTIN_GPIO	(192)
+#define NR_BUILTIN_GPIO		IRQ_GPIO_NUM
 
 #define gpio_to_bank(gpio)	((gpio) >> 5)
 #define gpio_to_irq(gpio)	(IRQ_GPIO_START + (gpio))
-- 
1.5.6.5
