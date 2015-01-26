From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Mon, 26 Jan 2015 18:06:36 +0800
Subject: [PATCH 3/7] pm: at91: pm_suspend: MOR register KEY was missing
In-Reply-To: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1422266796-24523-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Vilchez <patrice.vilchez@atmel.com>

Signed-off-by: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/pm_suspend.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/pm_suspend.S b/arch/arm/mach-at91/pm_suspend.S
index e796722..88cf228 100644
--- a/arch/arm/mach-at91/pm_suspend.S
+++ b/arch/arm/mach-at91/pm_suspend.S
@@ -229,6 +229,7 @@ sdr_sr_done:
 	/* Turn off the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	bic	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 skip_disable_main_clock:
@@ -241,6 +242,7 @@ skip_disable_main_clock:
 	/* Turn on the main oscillator */
 	ldr	tmp1, [pmc, #AT91_CKGR_MOR]
 	orr	tmp1, tmp1, #AT91_PMC_MOSCEN
+	orr	tmp1, tmp1, #AT91_PMC_KEY
 	str	tmp1, [pmc, #AT91_CKGR_MOR]
 
 	wait_moscrdy
-- 
1.7.9.5
