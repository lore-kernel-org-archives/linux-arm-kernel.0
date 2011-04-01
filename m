From: haojian.zhuang@marvell.com (Haojian Zhuang)
Date: Fri,  1 Apr 2011 10:39:26 +0800
Subject: [PATCH 7/9] ARM: pxa: align NR_BUILTIN_GPIO with GPIO interrupt number
In-Reply-To: <1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
References: <040101>
	<1301625568-16583-1-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-2-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-3-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-4-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-5-git-send-email-haojian.zhuang@marvell.com>
	<1301625568-16583-6-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <1301625568-16583-7-git-send-email-haojian.zhuang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Avoid to mismatch between NR_BUILTIN_GPIO and GPIO interrupt number

Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>
---
 arch/arm/mach-pxa/include/mach/gpio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/gpio.h b/arch/arm/mach-pxa/include/mach/gpio.h
index b024a8b..48ef925 100644
--- a/arch/arm/mach-pxa/include/mach/gpio.h
+++ b/arch/arm/mach-pxa/include/mach/gpio.h
@@ -99,7 +99,7 @@
 #define GAFR(x)		GPIO_REG(0x54 + (((x) & 0x70) >> 2))
 
 
-#define NR_BUILTIN_GPIO 128
+#define NR_BUILTIN_GPIO		PXA_GPIO_IRQ_NUM
 
 #define gpio_to_bank(gpio)	((gpio) >> 5)
 #define gpio_to_irq(gpio)	IRQ_GPIO(gpio)
-- 
1.5.6.5
