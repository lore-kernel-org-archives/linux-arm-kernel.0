From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Wed, 10 Jul 2013 12:30:16 -0300
Subject: [PATCH v3] ARM: imx: Select MIGHT_HAVE_CACHE_L2X0
Message-ID: <1373470216-12996-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Select MIGHT_HAVE_CACHE_L2X0 for armv6 and armv7 i.MX SoCs.

By selecting MIGHT_HAVE_CACHE_L2X0, the user still has the possibility to 
disable CACHE_L2X0 selection via menuconfig.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v2:
- Simplify the Kconfig
Changes since v1:
- Use MIGHT_HAVE_CACHE_L2X0 instead of CACHE_L2X0, to allow users to still
disable L2 cache via menuconfig if they want to
- Also select L2 cache for vf610

 arch/arm/mach-imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index f546560..f7a5ad1 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -8,6 +8,7 @@ config ARCH_MXC
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select MIGHT_HAVE_CACHE_L2X0 if ARCH_MULTI_V6_V7
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
 	select USE_OF
-- 
1.8.1.2
