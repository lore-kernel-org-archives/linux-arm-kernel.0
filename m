From: michael.opdenacker@free-electrons.com (Michael Opdenacker)
Date: Sat, 12 Oct 2013 04:57:20 +0200
Subject: [PATCH] [ARM] floppy.h: remove deprecated IRQF_DISABLED
Message-ID: <1381546640-4713-1-git-send-email-michael.opdenacker@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch proposes to remove the use of the IRQF_DISABLED flag

It's a NOOP since 2.6.35 and it will be removed one day.

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
---
 arch/arm/include/asm/floppy.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/floppy.h b/arch/arm/include/asm/floppy.h
index c9f03ec..f488255 100644
--- a/arch/arm/include/asm/floppy.h
+++ b/arch/arm/include/asm/floppy.h
@@ -25,7 +25,7 @@
 
 #define fd_inb(port)		inb((port))
 #define fd_request_irq()	request_irq(IRQ_FLOPPYDISK,floppy_interrupt,\
-					    IRQF_DISABLED,"floppy",NULL)
+					    0,"floppy",NULL)
 #define fd_free_irq()		free_irq(IRQ_FLOPPYDISK,NULL)
 #define fd_disable_irq()	disable_irq(IRQ_FLOPPYDISK)
 #define fd_enable_irq()		enable_irq(IRQ_FLOPPYDISK)
-- 
1.8.1.2
