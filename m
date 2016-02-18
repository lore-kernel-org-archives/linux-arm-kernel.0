From: vincent.stehle@laposte.net (=?UTF-8?q?Vincent=20Stehl=C3=A9?=)
Date: Fri, 19 Feb 2016 00:31:17 +0100
Subject: [PATCH next] ARM: virt: fix build of hyp-stub
Message-ID: <1455838277-11083-1-git-send-email-vincent.stehle@laposte.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Compile hyp-stub explicitly for arm v7-a. This fixes the following build
errors:

  arch/arm/kernel/hyp-stub.S: Assembler messages:
  arch/arm/kernel/hyp-stub.S:168: Error: selected processor does not support `ubfx r7,r7,#28,#4' in ARM mode
  arch/arm/kernel/hyp-stub.S:176: Error: selected processor does not support `isb' in ARM mode

Signed-off-by: Vincent Stehl? <vincent.stehle@laposte.net>
Cc: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
---


Hi,

This can be seen with linux next-20160218 and arm e.g. allmodconfig.

Best regards,

V.


 arch/arm/kernel/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 2c5f160..15684c5 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -88,6 +88,8 @@ obj-$(CONFIG_DEBUG_LL)	+= debug.o
 obj-$(CONFIG_EARLY_PRINTK)	+= early_printk.o
 
 obj-$(CONFIG_ARM_VIRT_EXT)	+= hyp-stub.o
+AFLAGS_hyp-stub.o		:=-Wa,-march=armv7-a
+
 ifeq ($(CONFIG_ARM_PSCI),y)
 obj-$(CONFIG_SMP)		+= psci_smp.o
 endif
-- 
2.7.0
