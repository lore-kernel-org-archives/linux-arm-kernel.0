From: magnus.damm@gmail.com (Magnus Damm)
Date: Tue, 09 Jul 2013 19:40:08 +0900
Subject: [PATCH 03/04] ARM: shmobile: No need to use INTC demux on r8a7740
In-Reply-To: <20130709103944.1891.67462.sendpatchset@w520>
References: <20130709103944.1891.67462.sendpatchset@w520>
Message-ID: <20130709104008.1891.17746.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Now when the r8a7740 code has been converted to make use of
GIC instead of INTC for root interrupt controller it is
possible to exclude the low level INTC demux function
shmobile_handle_irq_intc from linking. 

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/Makefile |    1 -
 1 file changed, 1 deletion(-)

--- 0003/arch/arm/mach-shmobile/Makefile
+++ work/arch/arm/mach-shmobile/Makefile	2013-07-09 18:54:03.000000000 +0900
@@ -23,7 +23,6 @@ smp-$(CONFIG_ARCH_EMEV2)	+= smp-emev2.o
 
 # IRQ objects
 obj-$(CONFIG_ARCH_SH7372)	+= entry-intc.o
-obj-$(CONFIG_ARCH_R8A7740)	+= entry-intc.o
 
 # PM objects
 obj-$(CONFIG_SUSPEND)		+= suspend.o
