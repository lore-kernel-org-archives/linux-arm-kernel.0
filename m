From: kmpark@infradead.org (Kyungmin Park)
Date: Mon, 02 Aug 2010 09:24:57 +0900
Subject: [PATCH 1/3] ARM: S5PC110/S5PC210: Add the C Preprocessor	directives
	for gpio.h
Message-ID: <20100802002457.GA32257@july>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kyungmin Park <kyungmin.park@samsung.com>

Make a buile error when include the mach/gpio.h directly.

Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pv210/include/mach/gpio.h |    4 ++++
 arch/arm/mach-s5pv310/include/mach/gpio.h |    4 ++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-s5pv210/include/mach/gpio.h b/arch/arm/mach-s5pv210/include/mach/gpio.h
index 1f4b595..7798693 100644
--- a/arch/arm/mach-s5pv210/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv210/include/mach/gpio.h
@@ -13,6 +13,10 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
+#ifndef __LINUX_GPIO_H
+#error "Don't include the mach/gpio.h directly. use the linux/gpio.h"
+#endif
+
 #define gpio_get_value	__gpio_get_value
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
diff --git a/arch/arm/mach-s5pv310/include/mach/gpio.h b/arch/arm/mach-s5pv310/include/mach/gpio.h
index 20cb80c..3f751f2 100644
--- a/arch/arm/mach-s5pv310/include/mach/gpio.h
+++ b/arch/arm/mach-s5pv310/include/mach/gpio.h
@@ -13,6 +13,10 @@
 #ifndef __ASM_ARCH_GPIO_H
 #define __ASM_ARCH_GPIO_H __FILE__
 
+#ifndef __LINUX_GPIO_H
+#error "Don't include the mach/gpio.h directly. use the linux/gpio.h"
+#endif
+
 #define gpio_get_value	__gpio_get_value
 #define gpio_set_value	__gpio_set_value
 #define gpio_cansleep	__gpio_cansleep
-- 
1.5.3.3
