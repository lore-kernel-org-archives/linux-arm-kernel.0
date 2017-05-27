From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sat, 27 May 2017 11:58:48 +0200
Subject: [PATCH 7/7] clocksource: Rename CLKSRC_ACPI
In-Reply-To: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
References: <1495879129-28109-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1495879129-28109-7-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The config option name is now renamed to 'CLKSRC_ACPI' for consistency with
the CLOCKSOURCE_OF_DECLARE => TIMER_OF_DECLARE change.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 90f062e..4ba230d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -5,7 +5,7 @@ config TIMER_OF
 	bool
 	select TIMER_PROBE
 
-config CLKSRC_ACPI
+config TIMER_ACPI
 	bool
 	select TIMER_PROBE
 
@@ -310,7 +310,7 @@ config ARC_TIMERS_64BIT
 config ARM_ARCH_TIMER
 	bool
 	select TIMER_OF if OF
-	select CLKSRC_ACPI if ACPI
+	select TIMER_ACPI if ACPI
 
 config ARM_ARCH_TIMER_EVTSTREAM
 	bool "Enable ARM architected timer event stream generation by default"
-- 
2.7.4
