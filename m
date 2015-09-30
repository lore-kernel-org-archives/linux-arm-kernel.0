From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 30 Sep 2015 18:11:04 +0200
Subject: [PATCH 11/16] ARM: at91: pm: simply call at91_pm_init
In-Reply-To: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1443629469-15086-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1443629469-15086-12-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

at91_pm_init() doesn't return a value, as is the case for its callers,
simply call it instead of returning its non-existent return value.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/mach-at91/pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
index 80e277cfcc8b..5c2b60c5a2a1 100644
--- a/arch/arm/mach-at91/pm.c
+++ b/arch/arm/mach-at91/pm.c
@@ -427,7 +427,7 @@ void __init at91sam9260_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.memctrl = AT91_MEMCTRL_SDRAMC;
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
-	return at91_pm_init();
+	at91_pm_init();
 }
 
 void __init at91sam9g45_pm_init(void)
@@ -435,7 +435,7 @@ void __init at91sam9g45_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	return at91_pm_init();
+	at91_pm_init();
 }
 
 void __init at91sam9x5_pm_init(void)
@@ -443,5 +443,5 @@ void __init at91sam9x5_pm_init(void)
 	at91_dt_ramc();
 	at91_pm_data.uhp_udp_mask = AT91SAM926x_PMC_UHP | AT91SAM926x_PMC_UDP;
 	at91_pm_data.memctrl = AT91_MEMCTRL_DDRSDR;
-	return at91_pm_init();
+	at91_pm_init();
 }
-- 
2.1.4
