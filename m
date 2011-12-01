From: axel.lin@gmail.com (Axel Lin)
Date: Thu, 01 Dec 2011 23:25:45 +0800
Subject: [PATCH 2/2] ARM: exynos4: Fix build error
In-Reply-To: <1322753070.11611.0.camel@phoenix>
References: <1322753070.11611.0.camel@phoenix>
Message-ID: <1322753145.11611.1.camel@phoenix>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Trivial fix to fix below build error:

  CC      arch/arm/mach-exynos/mach-universal_c210.o
arch/arm/mach-exynos/mach-universal_c210.c:24: error: expected identifier or '(' before '<' token

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 arch/arm/mach-exynos/mach-universal_c210.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-exynos/mach-universal_c210.c b/arch/arm/mach-exynos/mach-universal_c210.c
index 48e85b0..cfc7d50 100644
--- a/arch/arm/mach-exynos/mach-universal_c210.c
+++ b/arch/arm/mach-exynos/mach-universal_c210.c
@@ -21,7 +21,7 @@
 #include <linux/mmc/host.h>
 #include <linux/i2c-gpio.h>
 #include <linux/i2c/mcs.h>
- <linux/i2c/atmel_mxt_ts.h>
+#include <linux/i2c/atmel_mxt_ts.h>
 
 #include <asm/mach/arch.h>
 #include <asm/hardware/gic.h>
-- 
1.7.5.4
