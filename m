From: Li.Xiubo@freescale.com (Xiubo Li)
Date: Fri, 26 Sep 2014 17:47:09 +0800
Subject: [PATCH] ARM: Kconfig: Increase FORCE_MAX_ZONEORDER for FSL LS1021A
 SoC.
Message-ID: <1411724829-43079-1-git-send-email-Li.Xiubo@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FORCE_MAX_ZONEORDER of 12 is needed to allocate more than 4MB of
consistent DMA memory for DCU frame buffer driver.

Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e7a18f4..d7f1ede 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1703,7 +1703,7 @@ source "mm/Kconfig"
 config FORCE_MAX_ZONEORDER
 	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
 	range 11 64 if ARCH_SHMOBILE_LEGACY
-	default "12" if SOC_AM33XX
+	default "12" if SOC_AM33XX || SOC_LS1021A
 	default "9" if SA1111 || ARCH_EFM32
 	default "11"
 	help
-- 
2.1.0.27.g96db324
