From: dave.martin@linaro.org (Dave Martin)
Date: Fri, 16 Dec 2011 16:35:31 +0000
Subject: [PATCH v5 REPOST 4/5] highbank: Unconditionally require l2x0 L2 cache
 controller support
In-Reply-To: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
References: <1324053332-6431-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1324053332-6431-5-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If running in the Normal World on a TrustZone-enabled SoC, Linux
does not have complete control over the L2 cache controller
configuration.  The kernel cannot work reliably on such platforms
without the l2x0 cache support code built in.

This patch unconditionally enables l2x0 support for the Highbank
SoC.

Thanks to Rob Herring for this suggestion.  [1]

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html

Signed-off-by: Dave Martin <dave.martin@linaro.org>
Acked-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index eca82f9..1792146 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -340,12 +340,12 @@ config ARCH_HIGHBANK
 	select ARM_AMBA
 	select ARM_GIC
 	select ARM_TIMER_SP804
+	select CACHE_L2X0
 	select CLKDEV_LOOKUP
 	select CPU_V7
 	select GENERIC_CLOCKEVENTS
 	select HAVE_ARM_SCU
 	select HAVE_SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select USE_OF
 	help
 	  Support for the Calxeda Highbank SoC based boards.
-- 
1.7.4.1
