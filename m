From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 11 Aug 2011 12:05:52 -0600
Subject: [PATCH] ARM: tegra: Fix <mach/gpio.h> to have necessary #includes
Message-ID: <1313085952-26365-1-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without this, EINVAL isn't defined, and type bool isn't declared.
This leads to compilation failures.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/gpio.h |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index e353805..96af4ff 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -20,7 +20,8 @@
 #ifndef __MACH_TEGRA_GPIO_H
 #define __MACH_TEGRA_GPIO_H
 
-#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 #include <mach/irqs.h>
 
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
-- 
1.7.0.4
