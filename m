From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Sun,  5 Aug 2012 16:03:37 -0700
Subject: [PATCH 7/9] ARM: FIQ: Should include asm/mach/irq.h
In-Reply-To: <20120805230238.GA1663@lizard>
References: <20120805230238.GA1663@lizard>
Message-ID: <1344207819-3415-7-git-send-email-anton.vorontsov@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patch fixes the following sparse warnings:

  CHECK   arch/arm/kernel/fiq.c
arch/arm/kernel/fiq.c:71:6: warning: symbol 'show_fiq_list' was not declared. Should it be static?
arch/arm/kernel/fiq.c:129:13: warning: symbol 'init_FIQ' was not declared. Should it be static?

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 arch/arm/kernel/fiq.c |    1 +
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
1.7.10.4
