From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 1 Jul 2015 13:53:02 -0400
Subject: [PATCH] ARM: keystone: allow FORCE_MAX_ZONEORDER to be configurable
 on Keystone
Message-ID: <1435773182-23074-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently for Keystone devices, user can't change the
value of CONFIG_FORCE_MAX_ZONEORDER option in defconfig.
Users require capability to tune the value of this option on a target
board. So this patch adds this capability

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 arch/arm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a750c14..9b5f8bc 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1731,7 +1731,7 @@ config ARM_MODULE_PLTS
 source "mm/Kconfig"
 
 config FORCE_MAX_ZONEORDER
-	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY
+	int "Maximum zone order" if ARCH_SHMOBILE_LEGACY || ARCH_KEYSTONE
 	range 11 64 if ARCH_SHMOBILE_LEGACY
 	default "12" if SOC_AM33XX
 	default "9" if SA1111 || ARCH_EFM32
-- 
1.9.1
