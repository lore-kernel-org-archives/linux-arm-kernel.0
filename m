From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Sat, 8 Jun 2013 10:17:43 +0800
Subject: [PATCH] Change the internal SRAM memory type MT_MEMORY_NONCACHED
In-Reply-To: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
References: <1369011911-21282-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1370657863-8725-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because MT_DEVICE is not executable in armv7, we change
the internal SRAM memory type to MT_MEMORY_NONCACHED.
As it seems that caching this internal SRAM memory is not necessary,
we chose the this memory type.

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/setup.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index a33d4b5..98d55ef 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -84,7 +84,7 @@ void __init at91_init_sram(int bank, unsigned long base, unsigned int length)
 
 	desc->pfn = __phys_to_pfn(base);
 	desc->length = length;
-	desc->type = MT_DEVICE;
+	desc->type = MT_MEMORY_NONCACHED;
 
 	pr_info("AT91: sram at 0x%lx of 0x%x mapped at 0x%lx\n",
 		base, length, desc->virtual);
-- 
1.7.9.5
