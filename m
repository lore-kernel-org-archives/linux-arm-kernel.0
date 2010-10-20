From: colin.tuckley@arm.com (Colin Tuckley)
Date: Wed, 20 Oct 2010 14:03:22 +0100
Subject: [PATCH 6/6] ARM Realview PCIX build file changes
In-Reply-To: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
References: <20101020125554.22199.78597.stgit@e102602-lin.cambridge.arm.com>
Message-ID: <20101020130322.22199.55098.stgit@e102602-lin.cambridge.arm.com>
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
index 9c26ba7..05c7aa2 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1143,7 +1143,9 @@ config ISA_DMA_API
 	bool
 
 config PCI
-	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX
+	bool "PCI support" if ARCH_INTEGRATOR_AP || ARCH_VERSATILE_PB || \
+	ARCH_IXP4XX || ARCH_KS8695 || MACH_ARMCORE || ARCH_CNS3XXX || \
+	MACH_REALVIEW_PB11MP || MACH_REALVIEW_PBA8 || MACH_REALVIEW_PBX
 	help
 	  Find out whether you have a PCI motherboard. PCI is the name of a
 	  bus system, i.e. the way the CPU talks to the other stuff inside
@@ -1171,6 +1173,8 @@ config PCI_HOST_ITE8152
 
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
