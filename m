From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Thu, 22 Nov 2012 16:50:00 -0800
Subject: [PATCH 07/10] ARM: FIQ: Should include asm/mach/irq.h
In-Reply-To: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
References: <20121123003849.GA973@lizard.mcd25758.sjc.wayport.net>
Message-ID: <1353631803-4853-7-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch fixes the following sparse warnings:

  CHECK   arch/arm/kernel/fiq.c
arch/arm/kernel/fiq.c:71:6: warning: symbol 'show_fiq_list' was not declared. Should it be static?
arch/arm/kernel/fiq.c:129:13: warning: symbol 'init_FIQ' was not declared. Should it be static?

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/kernel/fiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/kernel/fiq.c b/arch/arm/kernel/fiq.c
index bd369c5..7be2e74 100644
--- a/arch/arm/kernel/fiq.c
+++ b/arch/arm/kernel/fiq.c
@@ -46,6 +46,7 @@
 #include <asm/fiq.h>
 #include <asm/irq.h>
 #include <asm/traps.h>
+#include <asm/mach/irq.h>
 
 static unsigned long no_fiq_insn;
 
-- 
1.8.0
