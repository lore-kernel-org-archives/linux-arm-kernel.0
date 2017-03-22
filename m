From: jonathanh@nvidia.com (Jon Hunter)
Date: Wed, 22 Mar 2017 17:00:52 +0000
Subject: [PATCH V2 1/5] ARM: tegra: Remove unnecessary inclusion of flowctrl
 header
In-Reply-To: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
References: <1490202056-13040-1-git-send-email-jonathanh@nvidia.com>
Message-ID: <1490202056-13040-2-git-send-email-jonathanh@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Tegra flowctrl.h header is included unnecessarily by the Tegra
sleep.S source file. Remove this unnecessary inclusion.

Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 arch/arm/mach-tegra/sleep.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-tegra/sleep.S b/arch/arm/mach-tegra/sleep.S
index f024a5109e8e..5e3496753df1 100644
--- a/arch/arm/mach-tegra/sleep.S
+++ b/arch/arm/mach-tegra/sleep.S
@@ -30,8 +30,6 @@
 #include <asm/hardware/cache-l2x0.h>
 
 #include "iomap.h"
-
-#include "flowctrl.h"
 #include "sleep.h"
 
 #define CLK_RESET_CCLK_BURST	0x20
-- 
2.7.4
