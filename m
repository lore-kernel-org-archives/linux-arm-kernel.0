From: s-anna@ti.com (Suman Anna)
Date: Wed, 11 Jan 2017 19:48:39 -0600
Subject: [PATCH v2 1/5] ARM: Keystone: Enable ARCH_HAS_RESET_CONTROLLER
In-Reply-To: <20170112014843.19569-1-s-anna@ti.com>
References: <20170112014843.19569-1-s-anna@ti.com>
Message-ID: <20170112014843.19569-2-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Keystone 2 family of SoCs will use various Reset Controller
drivers for managing the resets of remote processor devices like
DSPs on the SoC, so select the ARCH_HAS_RESET_CONTROLLER option
by default to enable the Reset framework.

Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
v2: No changes

 arch/arm/mach-keystone/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 24bd64dabdfc..554357035f30 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -4,6 +4,7 @@ config ARCH_KEYSTONE
 	select ARM_GIC
 	select HAVE_ARM_ARCH_TIMER
 	select KEYSTONE_TIMER
+	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
 	select ARCH_SUPPORTS_BIG_ENDIAN
-- 
2.10.2
