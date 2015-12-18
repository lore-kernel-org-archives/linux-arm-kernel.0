From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:27 +0100
Subject: [PATCH 14/69] clocksource/drivers/pistachio: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-14-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8ea7140..96a34dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -121,8 +121,10 @@ config CLKSRC_LPC32XX
 	select CLKSRC_OF
 
 config CLKSRC_PISTACHIO
-	bool
+	bool "Clocksource for Pistachio SoC" if COMPILE_TEST
 	select CLKSRC_OF
+	help
+	  Enables the clocksource for the Pistachio SoC.
 
 config CLKSRC_TI_32K
 	bool "Texas Instruments 32.768 Hz Clocksource" if COMPILE_TEST
-- 
1.9.1
