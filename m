From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 11 Aug 2011 14:43:24 -0600
Subject: [PATCH v2 4/4] arm/tegra: mach/gpio.h: include linux/types.h to fix
	build
In-Reply-To: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
References: <1313095404-27858-1-git-send-email-swarren@nvidia.com>
Message-ID: <1313095404-27858-4-git-send-email-swarren@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tegra's <mach/gpio.h> uses type bool; we need to include <linux/types.h>
to get the definition.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/mach-tegra/include/mach/gpio.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-tegra/include/mach/gpio.h b/arch/arm/mach-tegra/include/mach/gpio.h
index 284a19e..7910d26 100644
--- a/arch/arm/mach-tegra/include/mach/gpio.h
+++ b/arch/arm/mach-tegra/include/mach/gpio.h
@@ -20,7 +20,7 @@
 #ifndef __MACH_TEGRA_GPIO_H
 #define __MACH_TEGRA_GPIO_H
 
-#include <linux/init.h>
+#include <linux/types.h>
 #include <mach/irqs.h>
 
 #define TEGRA_NR_GPIOS		INT_GPIO_NR
-- 
1.7.0.4
