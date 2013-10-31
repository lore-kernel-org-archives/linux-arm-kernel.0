From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 31 Oct 2013 09:10:19 -0700
Subject: [PATCH 6/6] arm: zynq: headsmp: Move .glbl out of actual code
In-Reply-To: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383235819-2552-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383235819-2552-7-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the .glbl lines exporting symbols to the top of the file and out of
the actual code, in order to make the code more readable.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/mach-zynq/headsmp.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-zynq/headsmp.S b/arch/arm/mach-zynq/headsmp.S
index 57a32869f0aa..12d1b40c7d78 100644
--- a/arch/arm/mach-zynq/headsmp.S
+++ b/arch/arm/mach-zynq/headsmp.S
@@ -9,14 +9,15 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 
+.globl zynq_secondary_trampoline_jump
+.globl zynq_secondary_trampoline_end
+
 ENTRY(zynq_secondary_trampoline)
 	ldr	r0, [pc]
 	bx	r0
-.globl zynq_secondary_trampoline_jump
 zynq_secondary_trampoline_jump:
 	/* Space for jumping address */
 	.word	/* cpu 1 */
-.globl zynq_secondary_trampoline_end
 zynq_secondary_trampoline_end:
 ENDPROC(zynq_secondary_trampoline)
 
-- 
1.8.4.1
