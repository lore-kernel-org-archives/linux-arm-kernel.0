From: j.weitzel@phytec.de (Jan Weitzel)
Date: Fri, 8 Jul 2011 12:04:22 +0200
Subject: [PATCH 1/3] ARM: OMAP4: Add pcm049 to Kconfig/Makefile
In-Reply-To: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
References: <1310119464-3514-1-git-send-email-j.weitzel@phytec.de>
Message-ID: <1310119464-3514-2-git-send-email-j.weitzel@phytec.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Jan Weitzel <j.weitzel@phytec.de>
---
 arch/arm/mach-omap2/Kconfig  |    5 +++++
 arch/arm/mach-omap2/Makefile |    4 ++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
index 19d5891..c6a2d43 100644
--- a/arch/arm/mach-omap2/Kconfig
+++ b/arch/arm/mach-omap2/Kconfig
@@ -323,6 +323,11 @@ config MACH_OMAP4_PANDA
 	select OMAP_PACKAGE_CBS
 	select REGULATOR_FIXED_VOLTAGE
 
+config MACH_PCM049
+	bool "OMAP4 based phyCORE OMAP4"
+	depends on ARCH_OMAP4
+	select OMAP_PACKAGE_CBS
+
 config OMAP3_EMU
 	bool "OMAP3 debugging peripherals"
 	depends on ARCH_OMAP3
diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b148077..e81b594 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -238,6 +238,10 @@ obj-$(CONFIG_MACH_OMAP4_PANDA)		+= board-omap4panda.o \
 					   hsmmc.o \
 					   omap_phy_internal.o
 
+obj-$(CONFIG_MACH_PCM049)		+= board-omap4pcm049.o \
+					   hsmmc.o \
+					   omap_phy_internal.o
+
 obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
 					   omap_phy_internal.o \
 
-- 
1.7.0.4
