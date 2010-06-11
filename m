From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Fri, 11 Jun 2010 17:33:19 +0900
Subject: [PATCH v2 3/4] ARM: S5PC100: Move external interrupt defines
In-Reply-To: <1276245200-18052-1-git-send-email-jy0922.shim@samsung.com>
References: <1276245200-18052-1-git-send-email-jy0922.shim@samsung.com>
Message-ID: <1276245200-18052-3-git-send-email-jy0922.shim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch moves external interrupt defines from gpio.h to regs-gpio.h
for consistency with s5pv210.

Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/mach-s5pc100/include/mach/gpio.h      |    7 -------
 arch/arm/mach-s5pc100/include/mach/regs-gpio.h |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-s5pc100/include/mach/gpio.h b/arch/arm/mach-s5pc100/include/mach/gpio.h
index 71ae1f5..29a8a12 100644
--- a/arch/arm/mach-s5pc100/include/mach/gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/gpio.h
@@ -146,13 +146,6 @@ enum s5p_gpio_number {
 /* define the number of gpios we need to the one after the MP04() range */
 #define ARCH_NR_GPIOS		(S5PC100_GPIO_END + 1)
 
-#define EINT_MODE		S3C_GPIO_SFN(0x2)
-
-#define EINT_GPIO_0(x)		S5PC100_GPH0(x)
-#define EINT_GPIO_1(x)		S5PC100_GPH1(x)
-#define EINT_GPIO_2(x)		S5PC100_GPH2(x)
-#define EINT_GPIO_3(x)		S5PC100_GPH3(x)
-
 #include <asm-generic/gpio.h>
 
 #endif /* __ASM_ARCH_GPIO_H */
diff --git a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
index dd6295e..6abe481 100644
--- a/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
+++ b/arch/arm/mach-s5pc100/include/mach/regs-gpio.h
@@ -71,5 +71,12 @@
 #define S5P_EXTINT_RISEEDGE		(0x03)
 #define S5P_EXTINT_BOTHEDGE		(0x04)
 
+#define EINT_MODE		S3C_GPIO_SFN(0x2)
+
+#define EINT_GPIO_0(x)		S5PC100_GPH0(x)
+#define EINT_GPIO_1(x)		S5PC100_GPH1(x)
+#define EINT_GPIO_2(x)		S5PC100_GPH2(x)
+#define EINT_GPIO_3(x)		S5PC100_GPH3(x)
+
 #endif /* __ASM_MACH_S5PC100_REGS_GPIO_H */
 
-- 
1.7.0.4
