From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:29 +0100
Subject: [PATCH 16/69] clocksource/drivers/rockchip: Add COMPILE_TEST option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-16-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Due to the dsb() usage in the driver, this driver is only compilable on
ARM and ARM64.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 3ba43f6..0c06103 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -39,8 +39,11 @@ config DW_APB_TIMER_OF
 	select CLKSRC_OF
 
 config ROCKCHIP_TIMER
-	bool
+	bool "Rockchip timer driver" if COMPILE_TEST
+	depends on ARM || ARM64
 	select CLKSRC_OF
+	help
+	  Enables the support for the rockchip timer driver.
 
 config ARMADA_370_XP_TIMER
 	bool
-- 
1.9.1
