From: mesihkilinc@gmail.com (Mesih Kilinc)
Date: Sun, 25 Nov 2018 10:43:03 +0300
Subject: [RFC PATCH v4 01/17] ARM: add CONFIG_ARCH_SUNXI_V7 for differentiate
 ARMv5/v7 Allwinner SoCs
In-Reply-To: <cover.1543125196.git.mesihkilinc@gmail.com>
References: <cover.1543125196.git.mesihkilinc@gmail.com>
Message-ID: <e83e1b25069f3fa4925e5e5f6b9eca3190532b98.1543125196.git.mesihkilinc@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner also has some ARMv5 SoCs.

In order to add support for them, check ARM_MULTI_V7 before enabling
ARMv7 SoC's.

Signed-off-by: Mesih Kilinc <mesihkilinc@gmail.com>
---
 arch/arm/mach-sunxi/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index d9c8ecf..185c573 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -9,9 +9,13 @@ menuconfig ARCH_SUNXI
 	select PM_OPP
 	select SUN4I_TIMER
 	select RESET_CONTROLLER
+	help
+	  Support for Allwinner ARM-based family of processors
 
 if ARCH_SUNXI
 
+if ARCH_MULTI_V7
+
 config MACH_SUN4I
 	bool "Allwinner A10 (sun4i) SoCs support"
 	default ARCH_SUNXI
@@ -56,3 +60,5 @@ config ARCH_SUNXI_MC_SMP
 	select ARM_CPU_SUSPEND
 
 endif
+
+endif
-- 
2.7.4
