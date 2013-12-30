From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 30 Dec 2013 11:19:36 +0100
Subject: [PATCH 17/20] clocksource: tegra: Remove deprecated IRQF_DISABLED
In-Reply-To: <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
References: <52C1479E.80808@linaro.org>
 <1388398779-11222-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1388398779-11222-17-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Opdenacker <michael.opdenacker@free-electrons.com>

This patch removes the use of the IRQF_DISABLED flag.

It's a NOOP since 2.6.35 and it will be removed one day.

[dlezcano] : slightly changed the changelog

Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/tegra20_timer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index 6428492..d1869f0 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -149,7 +149,7 @@ static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
 
 static struct irqaction tegra_timer_irq = {
 	.name		= "timer0",
-	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_TRIGGER_HIGH,
+	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
 	.handler	= tegra_timer_interrupt,
 	.dev_id		= &tegra_clockevent,
 };
-- 
1.7.9.5
