From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 19:40:01 +0900
Subject: [PATCH 02/04] ARM: shmobile: Use pm-rmobile on sh7372 and r8a7740 only
In-Reply-To: <20130709103944.1891.67462.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
Message-ID: <20130709104001.1891.16375.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The functions in pm-rmobile.c are only used on sh7372 and
r8a7740, so adjust the Makefile to only link in that file
in case those SoCs are selected.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- 0001/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-09 18:50:08.000000000 +0900
@@ -28,11 +28,10 @@ obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
 obj-$(CONFIG_CPU_IDLE)		+= cpuidle.o
-obj-$(CONFIG_ARCH_SHMOBILE)	+= pm-rmobile.o
-obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o
-obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o
-obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
+obj-$(CONFIG_ARCH_SH7372)	+= pm-sh7372.o sleep-sh7372.o pm-rmobile.o
 obj-$(CONFIG_ARCH_SH73A0)	+= pm-sh73a0.o
+obj-$(CONFIG_ARCH_R8A7740)	+= pm-r8a7740.o pm-rmobile.o
+obj-$(CONFIG_ARCH_R8A7779)	+= pm-r8a7779.o
 
 # Board objects
 obj-$(CONFIG_MACH_AG5EVM)	+= board-ag5evm.o
