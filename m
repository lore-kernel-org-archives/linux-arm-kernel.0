From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 12 Sep 2016 11:15:47 +0200
Subject: [PATCH 9/9] clocksource/drivers/oxnas: Add OX820 compatible
In-Reply-To: <1473671747-9400-1-git-send-email-daniel.lezcano@linaro.org>
References: <b04803ca-5506-bf69-04df-f28efbc9a94a@linaro.org>
 <1473671747-9400-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1473671747-9400-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Neil Armstrong <narmstrong@baylibre.com>

In order to support the Oxford Semiconductor OX820 SoC, add new
compatible string to rps timer driver.
Also add new string in the dt-bindings.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt | 2 +-
 drivers/clocksource/timer-oxnas-rps.c                        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt b/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
index 3ca89cd..d191612 100644
--- a/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
+++ b/Documentation/devicetree/bindings/timer/oxsemi,rps-timer.txt
@@ -2,7 +2,7 @@ Oxford Semiconductor OXNAS SoCs Family RPS Timer
 ================================================
 
 Required properties:
-- compatible: Should be "oxsemi,ox810se-rps-timer"
+- compatible: Should be "oxsemi,ox810se-rps-timer" or "oxsemi,ox820-rps-timer"
 - reg : Specifies base physical address and size of the registers.
 - interrupts : The interrupts of the two timers
 - clocks : The phandle of the timer clock source
diff --git a/drivers/clocksource/timer-oxnas-rps.c b/drivers/clocksource/timer-oxnas-rps.c
index bd887e2..d630bf4 100644
--- a/drivers/clocksource/timer-oxnas-rps.c
+++ b/drivers/clocksource/timer-oxnas-rps.c
@@ -295,3 +295,5 @@ err_alloc:
 
 CLOCKSOURCE_OF_DECLARE(ox810se_rps,
 		       "oxsemi,ox810se-rps-timer", oxnas_rps_timer_init);
+CLOCKSOURCE_OF_DECLARE(ox820_rps,
+		       "oxsemi,ox820se-rps-timer", oxnas_rps_timer_init);
-- 
2.7.4
