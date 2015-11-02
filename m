From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon,  2 Nov 2015 13:56:30 +0100
Subject: [PATCH 02/22] clocksource/drivers/mediatek: Add the COMPILE_TEST
 option
In-Reply-To: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
References: <1446469011-22710-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1446469011-22710-2-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a1c9312..dc79fde 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -210,9 +210,11 @@ config SYS_SUPPORTS_SH_CMT
         bool
 
 config MTK_TIMER
+	bool "Mediatek timer driver" if COMPILE_TEST
 	select CLKSRC_OF
 	select CLKSRC_MMIO
-	bool
+	help
+	  Support for Mediatek timer driver.
 
 config SYS_SUPPORTS_SH_MTU2
         bool
-- 
1.9.1
