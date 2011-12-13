From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 13 Dec 2011 17:56:31 +0000
Subject: [PATCH v4 3/5] omap4: Unconditionally require l2x0 L2 cache
 controller support
In-Reply-To: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
References: <1323798993-8727-1-git-send-email-dave.martin@linaro.org>
Message-ID: <1323798993-8727-4-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If running in the Normal World on a TrustZone-enabled SoC, Linux
does not have complete control over the L2 cache controller
configuration.  The kernel cannot work reliably on such platforms
without the l2x0 cache support code built in.

This patch unconditionally enables l2x0 support for the OMAP4 SoCs.

Thanks to Rob Herring for this suggestion. [1]

Signed-off-by: Dave Martin <dave.martin@linaro.org>

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2011-November/074495.html
---
 arch/arm/mach-omap2/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index bb1b670..94e568a 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -41,11 +41,11 @@ config ARCH_OMAP4
 	bool "TI OMAP4"
 	default y
 	depends on ARCH_OMAP2PLUS
+	select CACHE_L2X0
 	select CPU_V7
 	select ARM_GIC
 	select HAVE_SMP
 	select LOCAL_TIMERS if SMP
-	select MIGHT_HAVE_CACHE_L2X0
 	select PL310_ERRATA_588369
 	select PL310_ERRATA_727915
 	select ARM_ERRATA_720789
-- 
1.7.4.1
