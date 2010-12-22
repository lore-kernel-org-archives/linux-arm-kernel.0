From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 22 Dec 2010 14:04:26 +0000
Subject: [PATCH 6/6] ARM Realview PCIX build file changes
In-Reply-To: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
References: <20101222140305.29725.50845.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20101222140426.29725.23983.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds PCI support for the Realview boards
to the mach-realview build system.

Signed-off-by: Colin Tuckley <colin.tuckley@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---

 arch/arm/Kconfig                |    6 +++++-
 arch/arm/mach-realview/Makefile |    6 ++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index d56d21c..c653f04 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1164,7 +1164,9 @@ config ISA_DMA_API
 	bool
 
 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
+	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || \
+	ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX || \
+	MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBA8 || MACH_REALVIEW_PBX
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -1192,6 +1194,8 @@ config PCI_HOST_ITE8152
 
 source "drivers/pci/Kconfig"
 
+source "drivers/pci/pcie/Kconfig"
+
 source "drivers/pcmcia/Kconfig"
 
 endmenu
diff --git a/arch/arm/mach-realview/Makefile b/arch/arm/mach-realview/Makefile
index a01b76b..bb2d414 100644
--- a/arch/arm/mach-realview/Makefile
+++ b/arch/arm/mach-realview/Makefile
@@ -10,4 +10,10 @@ obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= realview_pba8.o
 obj-$(CONFIG_MACH_REALVIEW_PBX)		+= realview_pbx.o
 obj-$(CONFIG_SMP)			+= platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)		+= hotplug.o
+ifeq ($(CONFIG_PCI),y)
+obj-$(CONFIG_MACH_REALVIEW_PB11MP)	+= pcix.o
+obj-$(CONFIG_MACH_REALVIEW_PBA8)	+= pcix.o
+obj-$(CONFIG_MACH_REALVIEW_PBX)		+= pcix.o
+endif
+
 obj-$(CONFIG_LOCAL_TIMERS)		+= localtimer.o
