From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sat, 14 May 2011 09:51:26 -0700
Subject: [PATCH] ARM: SAMSUNG: Depend on IRQ_GENERIC_CHIP
Message-ID: <1305391886-20963-1-git-send-email-broonie@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The generic chip infrastructure has had a Kconfig symbol added so we need
to select that for the kernel to link now we're using the generic IRQ
chip infrastructure.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 arch/arm/plat-samsung/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/Kconfig b/arch/arm/plat-samsung/Kconfig
index be72100..4d79519 100644
--- a/arch/arm/plat-samsung/Kconfig
+++ b/arch/arm/plat-samsung/Kconfig
@@ -8,6 +8,7 @@ config PLAT_SAMSUNG
 	bool
 	depends on PLAT_S3C24XX || ARCH_S3C64XX || PLAT_S5P
 	select NO_IOPORT
+	select GENERIC_IRQ_CHIP
 	default y
 	help
 	  Base platform code for all Samsung SoC based systems
-- 
1.7.5.1
