From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 20 Apr 2016 15:34:31 +0200
Subject: [PATCH] ARM: SoCFPGA: Fix secondary CPU startup in thumb2 kernel
Message-ID: <1461159271-3764-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The secondary CPU starts up in ARM mode. When the kernel is compiled in
thumb2 mode we have to explicitly compile the secondary startup
trampoline in ARM mode, otherwise the CPU will go to Nirvana.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Reported-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Suggested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: stable at vger.kernel.org
---
 arch/arm/mach-socfpga/headsmp.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-socfpga/headsmp.S b/arch/arm/mach-socfpga/headsmp.S
index 5d94b7a..c160fa3 100644
--- a/arch/arm/mach-socfpga/headsmp.S
+++ b/arch/arm/mach-socfpga/headsmp.S
@@ -13,6 +13,7 @@
 #include <asm/assembler.h>
 
 	.arch	armv7-a
+	.arm
 
 ENTRY(secondary_trampoline)
 	/* CPU1 will always fetch from 0x0 when it is brought out of reset.
-- 
2.8.0.rc3
