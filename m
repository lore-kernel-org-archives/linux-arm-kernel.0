From: mcoquelin.stm32@gmail.com (Maxime Coquelin)
Date: Tue,  8 Sep 2015 22:38:04 +0200
Subject: [PATCH v2 1/3] ARM: Make FORCE_MAX_ZONEORDER configurable if
 ARM_SINGLE_ARMV7M
In-Reply-To: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
References: <1441744686-20521-1-git-send-email-mcoquelin.stm32@gmail.com>
Message-ID: <1441744686-20521-2-git-send-email-mcoquelin.stm32@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes FORCE_MAX_ZONEORDER configurable in defconfig for ARMV7-M
when built for a single platform.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Maxime Coquelin <mcoquelin.stm32@gmail.com>
---
 arch/arm/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c14..88937b9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1731,10 +1731,10 @@ config ARM_MODULE_PLTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
+	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY || ARM_SINGLE_ARMV7M
 	range 11 64 if ARCH_SHMOBILE_LEGACY
 	default "12" if SOC_AM33XX
-	default "9" if SA1111 || ARCH_EFM32
+	default "9" if SA1111
 	default "11"
 	help
 	  The kernel memory allocator divides physically contiguous memory
-- 
1.9.1
