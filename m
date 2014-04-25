From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Fri, 25 Apr 2014 12:35:48 +0100
Subject: [PATCH 057/222] ARM: l2c: nomadik: remove cache size override
In-Reply-To: <20140425112951.GK26756@n2100.arm.linux.org.uk>
References: <20140425112951.GK26756@n2100.arm.linux.org.uk>
Message-ID: <E1WdeQ0-0007Gy-62@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-nomadik/cpu-8815.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-nomadik/cpu-8815.c b/arch/arm/mach-nomadik/cpu-8815.c
index 4a1065e41e9c..0f245bcc6b7e 100644
--- a/arch/arm/mach-nomadik/cpu-8815.c
+++ b/arch/arm/mach-nomadik/cpu-8815.c
@@ -147,7 +147,7 @@ static void __init cpu8815_init_of(void)
 {
 #ifdef CONFIG_CACHE_L2X0
 	/* At full speed latency must be >=2, so 0x249 in low bits */
-	l2x0_of_init(0x00730249, 0xfe000fff);
+	l2x0_of_init(0x00700249, 0xfe0fefff);
 #endif
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
1.8.3.1
