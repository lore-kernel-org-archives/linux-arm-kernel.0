From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 07 Oct 2011 15:29:13 +0100
Subject: [PATCH 5/5 v4] ARM Realview PCIX build file changes
In-Reply-To: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
References: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20111007142901.19554.70107.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PCI support for the Realview boards
to the mach-realview build system.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/Kconfig                |    3 +++
 arch/arm/mach-realview/Makefile |    5 +++++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 3146ed3..3157f65 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -261,6 +261,7 @@ config ARCH_REALVIEW
 	select PLAT_VERSATILE_CLCD
 	select ARM_TIMER_SP804
 	select GPIO_PL061 if GPIOLIB
+	select MIGHT_HAVE_PCI
 	help
 	  This enables support for ARM Ltd RealView boards.
 
@@ -1359,6 +1360,8 @@ config PCI_HOST_ITE8152
 
 source "drivers/pci/Kconfig"
 
+source "drivers/pci/pcie/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index 541fa4c..1d4fea0 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -10,3 +10,8 @@ obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
 obj-$(CONFIG_SMP)			+= platsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= pcix.o
+obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= pcix.o
+obj-$(CONFIG_MACH_REALVIEW_PBX)		+= pcix.o
+endif
