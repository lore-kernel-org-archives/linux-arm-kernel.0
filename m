From: swarren@nvidia.com (Stephen Warren)
Date: Thu,  5 Jan 2012 13:29:30 -0700
Subject: [PATCH] ARM: Fix typo in conversion of ARCH_NR_GPIOS to Kconfig
Message-ID: <1325795370-21576-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 44986ab "ARM: 7240/1: Make ARCH_NR_GPIO a Kconfig variable"
spelled ARCH_NR_GPIOS as ARCH_NR_GPIO, hence making the change
ineffective. This change fixes that.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
This should probably go into 3.3 since the patch it fixes is there. I
don't think this issue affects any Tegra platform, but I didn't investigate
the other platforms that set CONFIG_ARCH_NR_GPIO by default now.

 arch/arm/include/asm/gpio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/gpio.h b/arch/arm/include/asm/gpio.h
index 7151753..c402e9b 100644
--- a/arch/arm/include/asm/gpio.h
+++ b/arch/arm/include/asm/gpio.h
@@ -2,7 +2,7 @@
 #define _ARCH_ARM_GPIO_H
 
 #if CONFIG_ARCH_NR_GPIO > 0
-#define ARCH_NR_GPIO CONFIG_ARCH_NR_GPIO
+#define ARCH_NR_GPIOS CONFIG_ARCH_NR_GPIO
 #endif
 
 /* not all ARM platforms necessarily support this API ... */
-- 
1.7.0.4
