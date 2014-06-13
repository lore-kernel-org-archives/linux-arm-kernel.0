From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Jun 2014 18:01:05 +0200
Subject: [PATCH 03/14] ARM: keystone requires ARM_PATCH_PHYS_VIRT
In-Reply-To: <1402675276-538682-1-git-send-email-arnd@arndb.de>
References: <1402675276-538682-1-git-send-email-arnd@arndb.de>
Message-ID: <1402675276-538682-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The dynamic relocation that the keystone platform performs
only works if we can pick the phys offset at boot time. It's
possible that there is another solution for this, but this
is the easiest workaround. Kernels with ARM_PATCH_PHYS_VIRT
are not portable across platforms, and I see no reason why
anyone would run a kernel without ARM_PATCH_PHYS_VIRT on
keystone.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index f50bc93..98a156a 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -1,6 +1,7 @@
 config ARCH_KEYSTONE
 	bool "Texas Instruments Keystone Devices"
 	depends on ARCH_MULTI_V7
+	depends on ARM_PATCH_PHYS_VIRT
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select CLKSRC_MMIO
-- 
1.8.3.2
