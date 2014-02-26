From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 26 Feb 2014 15:30:46 +0100
Subject: [PATCH] ARM: XEN depends on having a MMU
Message-ID: <1393425046-23317-1-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arch/arm/xen/enlighten.c (and maybe others) use MMU-specific functions
like pte_mkspecial which are only available on MMU builds. So let XEN
depend on MMU.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e25419817791..1eb3a250210a 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1903,6 +1903,7 @@ config XEN
 	depends on ARM && AEABI && OF
 	depends on CPU_V7 && !CPU_V6
 	depends on !GENERIC_ATOMIC64
+	depends on MMU
 	select ARM_PSCI
 	select SWIOTLB_XEN
 	select ARCH_DMA_ADDR_T_64BIT
-- 
1.8.5.3
