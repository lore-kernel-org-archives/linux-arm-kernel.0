From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue, 18 Mar 2014 10:33:55 +0800
Subject: [PATCH 1/3] ARM: at91: pm: add the socs support the DDRC controller
In-Reply-To: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
References: <1395110037-23151-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1395110037-23151-2-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

socs: at91sam9x5, at91sam9n12, sama5d3

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/mach-at91/pm.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 8bda1ce..7280d09 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -238,7 +238,10 @@ static int at91_pm_enter(suspend_state_t state)
 
 				if (cpu_is_at91rm9200())
 					memctrl = AT91_MEMCTRL_MC;
-				else if (cpu_is_at91sam9g45())
+				else if (cpu_is_at91sam9g45()
+					|| cpu_is_at91sam9x5()
+					|| cpu_is_at91sam9n12()
+					|| cpu_is_sama5d3())
 					memctrl = AT91_MEMCTRL_DDRSDR;
 #ifdef CONFIG_AT91_SLOW_CLOCK
 				/* copy slow_clock handler to SRAM, and call it */
-- 
1.7.9.5
