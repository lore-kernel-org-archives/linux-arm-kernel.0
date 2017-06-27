From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Tue, 27 Jun 2017 02:55:17 +0200
Subject: [PATCH 3/6] ARM: Prepare RDA8810PL
In-Reply-To: <20170627005520.23731-1-afaerber@suse.de>
References: <20170627005520.23731-1-afaerber@suse.de>
Message-ID: <20170627005520.23731-4-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce ARCH_RDA and mach-rda.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 arch/arm/Kconfig           | 2 ++
 arch/arm/Makefile          | 1 +
 arch/arm/mach-rda/Kconfig  | 7 +++++++
 arch/arm/mach-rda/Makefile | 1 +
 4 files changed, 11 insertions(+)
 create mode 100644 arch/arm/mach-rda/Kconfig
 create mode 100644 arch/arm/mach-rda/Makefile

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 6d2f77c77556..2aa61c16bd9b 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -802,6 +802,8 @@ source "arch/arm/mach-oxnas/Kconfig"
 
 source "arch/arm/mach-qcom/Kconfig"
 
+source "arch/arm/mach-rda/Kconfig"
+
 source "arch/arm/mach-realview/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index 47d3a1ab08d2..549d5a2724c0 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -199,6 +199,7 @@ machine-$(CONFIG_ARCH_ORION5X)		+= orion5x
 machine-$(CONFIG_ARCH_PICOXCELL)	+= picoxcell
 machine-$(CONFIG_ARCH_PXA)		+= pxa
 machine-$(CONFIG_ARCH_QCOM)		+= qcom
+machine-$(CONFIG_ARCH_RDA)		+= rda
 machine-$(CONFIG_ARCH_REALVIEW)		+= realview
 machine-$(CONFIG_ARCH_ROCKCHIP)		+= rockchip
 machine-$(CONFIG_ARCH_RPC)		+= rpc
diff --git a/arch/arm/mach-rda/Kconfig b/arch/arm/mach-rda/Kconfig
new file mode 100644
index 000000000000..dafab78d7aab
--- /dev/null
+++ b/arch/arm/mach-rda/Kconfig
@@ -0,0 +1,7 @@
+menuconfig ARCH_RDA
+	bool "RDA Micro SoCs"
+	depends on ARCH_MULTI_V7
+	select COMMON_CLK
+	select GENERIC_IRQ_CHIP
+	help
+	  This enables support for the RDA Micro 8810PL SoC family.
diff --git a/arch/arm/mach-rda/Makefile b/arch/arm/mach-rda/Makefile
new file mode 100644
index 000000000000..6bea3d3a2dd7
--- /dev/null
+++ b/arch/arm/mach-rda/Makefile
@@ -0,0 +1 @@
+obj- += dummy.o
-- 
2.12.3
