From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 15:59:29 +0100
Subject: [PATCH v2 6/8] ARM: at91: sama5d4: remove useless call to
 at91_init_sram
In-Reply-To: <1421333971-7581-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421333971-7581-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421333971-7581-7-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/sama5d4.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/sama5d4.c b/arch/arm/mach-at91/sama5d4.c
index 7638509639f4..fa127fb79221 100644
--- a/arch/arm/mach-at91/sama5d4.c
+++ b/arch/arm/mach-at91/sama5d4.c
@@ -56,7 +56,6 @@ static struct map_desc at91_io_desc[] __initdata = {
 static void __init sama5d4_map_io(void)
 {
 	iotable_init(at91_io_desc, ARRAY_SIZE(at91_io_desc));
-	at91_init_sram(0, SAMA5D4_NS_SRAM_BASE, SAMA5D4_NS_SRAM_SIZE);
 }
 
 AT91_SOC_START(sama5d4)
-- 
2.1.0
