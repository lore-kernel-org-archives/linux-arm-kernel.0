From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Mon, 22 Sep 2014 15:51:33 +0200
Subject: [RESEND PATCH] ARM: at91/PMC: don't forget to write PMC_PCDR register
 to disable clocks
Message-ID: <1411393893-12291-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When introducing support for sama5d3, the write to PMC_PCDR register has
been accidentally removed.

Reported-by: Nathalie Cyrille <nathalie.cyrille@atmel.com>
Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: <stable@vger.kernel.org> # 3.10.x and later
---

Sorry for the noise, typo in the cc list!

Ludovic

 arch/arm/mach-at91/clock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 034529d..d66f102 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -962,6 +962,7 @@ static int __init at91_clock_reset(void)
 	}
 
 	at91_pmc_write(AT91_PMC_SCDR, scdr);
+	at91_pmc_write(AT91_PMC_PCDR, pcdr);
 	if (cpu_is_sama5d3())
 		at91_pmc_write(AT91_PMC_PCDR1, pcdr1);
 
-- 
2.0.3
