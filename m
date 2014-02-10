From: michal.simek@xilinx.com (Michal Simek)
Date: Mon, 10 Feb 2014 11:37:03 +0100
Subject: [PATCH] ARM: zynq: Add waituart implementation
Message-ID: <13a04fc77bd93b2ad5a15a8967627a11fb7c8925.1392028615.git.michal.simek@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing waituart implementation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/arm/include/debug/zynq.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
index f9aa974..0b762fa 100644
--- a/arch/arm/include/debug/zynq.S
+++ b/arch/arm/include/debug/zynq.S
@@ -42,6 +42,9 @@
 		.endm

 		.macro	waituart,rd,rx
+1001:		ldr	\rd, [\rx, #UART_SR_OFFSET]
+		tst	\rd, #UART_SR_TXEMPTY
+		beq	1001b
 		.endm

 		.macro	busyuart,rd,rx
--
1.8.2.3

-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140210/cc6785ff/attachment.sig>
