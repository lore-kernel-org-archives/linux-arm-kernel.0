From: jiri.prchal@aksignal.cz (Jiri Prchal)
Date: Mon,  9 Jul 2012 11:16:15 +0200
Subject: [PATCH 2/2] ARM: at91: clock: fix PLLA overclocked warning
Message-ID: <1341825375-9143-1-git-send-email-jiri.prchal@aksignal.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fix false warning "PLLA overclocked". Maximum frequency for sam9260 is 210MHz as stated in atmel's datasheet. Originally there was plus 4.5%, so I add this 4.5% to new value too.

Signed-off-by: Jiri Prchal <jiri.prchal@aksignal.cz>
---
 arch/arm/mach-at91/clock.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index de2ec6b..e004308 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -707,7 +707,7 @@ static int __init at91_pmc_init(unsigned long main_clock)
 		if (plla.rate_hz > 800000000)
 			pll_overclock = true;
 	} else {
-		if (plla.rate_hz > 209000000)
+		if (plla.rate_hz > 219000000)
 			pll_overclock = true;
 	}
 	if (pll_overclock)
-- 
1.7.7
