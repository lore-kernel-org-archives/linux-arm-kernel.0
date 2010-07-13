From: eric.miao@canonical.com (Eric Miao)
Date: Tue, 13 Jul 2010 23:33:24 +0800
Subject: [PATCH 09/13] [ARM] Introduce ARCH_USES_DEFAULT_GPIO_H for default
	GPIO API definitions
In-Reply-To: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
References: <1279035208-7249-1-git-send-email-eric.miao@canonical.com>
Message-ID: <1279035208-7249-10-git-send-email-eric.miao@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Miao <eric.miao@canonical.com>
---
 arch/arm/Kconfig            |    3 +++
 arch/arm/include/asm/gpio.h |   10 ++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 70221ef..44aa8b3 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -53,6 +53,9 @@ config ARCH_USES_GETTIMEOFFSET
 config ARCH_USES_DEFAULT_IO_H
 	def_bool n
 
+config ARCH_USES_DEFAULT_GPIO_H
+	def_bool n
+
 config GENERIC_CLOCKEVENTS
 	bool
 
diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 166a7a3..aa80d3c 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -1,7 +1,17 @@
 #ifndef _ARCH_ARM_GPIO_H
 #define _ARCH_ARM_GPIO_H
 
+#ifndef CONFIG_ARCH_USES_DEFAULT_GPIO_H
 /* not all ARM platforms necessarily support this API ... */
 #include <mach/gpio.h>
+#else
+
+#include <asm-generic/gpio.h>
+
+#define gpio_get_value	__gpio_get_value
+#define gpio_set_value	__gpio_set_value
+#define gpio_cansleep	__gpio_cansleep
+#define gpio_to_irq	__gpio_to_irq
+#endif
 
 #endif /* _ARCH_ARM_GPIO_H */
-- 
1.7.1
