From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri,  3 Jan 2014 16:38:07 +0100
Subject: [PATCH] ARCH: mvebu: Makefile clean-up
Message-ID: <1388763487-28436-1-git-send-email-gregory.clement@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some objects depend on CONFIG_ARCH_MVEBU whereas this whole Makefile
depends on the same symbol. Moreover CONFIG_ARCH_MVEBU can't be
selected as a module. So we can simplify this Makefile by moving all
the object from obj-$(CONFIG_ARCH_MVEBU) to obj-y.

Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
---
Jason,

This patch is just a cosmetic one and it will conflict with the patch
fix I have just sent, but the conflict is trivial and I can resubmit
it as soon as the fix will be part of the 3.13-rc. If it is too late
for 3.14, just postpone it for 3.15.

Thanks,

Gregory

 arch/arm/mach-mvebu/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-mvebu/Makefile b/arch/arm/mach-mvebu/Makefile
index 2d04f0e21870..74ca9ae8ab9b 100644
--- a/arch/arm/mach-mvebu/Makefile
+++ b/arch/arm/mach-mvebu/Makefile
@@ -3,8 +3,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) := -I$(srctree)/$(src)/include \
 
 AFLAGS_coherency_ll.o		:= -Wa,-march=armv7-a
 
-obj-y				 += system-controller.o
+obj-y				 += coherency.o coherency_ll.o pmsu.o system-controller.o
 obj-$(CONFIG_MACH_ARMADA_370_XP) += armada-370-xp.o
-obj-$(CONFIG_ARCH_MVEBU)	 += coherency.o coherency_ll.o pmsu.o
 obj-$(CONFIG_SMP)                += platsmp.o headsmp.o
 obj-$(CONFIG_HOTPLUG_CPU)        += hotplug.o
-- 
1.8.1.2
