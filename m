From: chunyan.zhang@spreadtrum.com (Chunyan Zhang)
Date: Thu, 4 Dec 2014 19:24:24 +0800
Subject: [PATCH] arm64/include/asm: Fixed a warning about 'struct pt_regs'
Message-ID: <1417692264-18553-1-git-send-email-chunyan.zhang@spreadtrum.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If I include asm/irq.h on the top of my code, and set ARCH=arm64,
I'll get a compile warning, details are below:
warning: ?struct pt_regs?
declared inside parameter list [enabled by default]

This patch is suggested by Arnd, see:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-December/308270.html

Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
 arch/arm64/include/asm/irq.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index e1f7ecd..acedc7e 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -3,6 +3,8 @@
 
 #include <asm-generic/irq.h>
 
+struct pt_regs;
+
 extern void (*handle_arch_irq)(struct pt_regs *);
 extern void migrate_irqs(void);
 extern void set_handle_irq(void (*handle_irq)(struct pt_regs *));
-- 
1.7.9.5
