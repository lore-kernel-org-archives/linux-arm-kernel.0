From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:21 +0100
Subject: [PATCH 08/69] clocksource/drivers/qcom: Make COMPILE_TEST enabled for
 ARM architecture
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-8-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order to be consistent with the rest of the drivers compilation, let's
introduce the COMPILE_TEST option. Unfortunately, the delay.h code is not
portable, so the compilation test coverage will be restricted to the ARM
architecture.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 2eb5f0e..b423785 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -279,7 +279,12 @@ config EM_TIMER_STI
 	  such as EMEV2 from former NEC Electronics.
 
 config CLKSRC_QCOM
-	bool
+	bool "Qualcomm MSM timer" if COMPILE_TEST
+	depends on ARM
+	select CLKSRC_OF
+	help
+	  This enables the clocksource and the per CPU clockevent driver for the
+	  Qualcomm SoCs.
 
 config CLKSRC_VERSATILE
 	bool "ARM Versatile (Express) reference platforms clock source"
-- 
1.9.1
