From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:33 +0100
Subject: [PATCH 20/69] clocksource/drivers/digicolor: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-20-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 68a63b2..63a8c6f 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -28,7 +28,9 @@ config CLKSRC_MMIO
 	bool
 
 config DIGICOLOR_TIMER
-	bool
+	bool "Digicolor timer driver" if COMPILE_TEST
+	help
+	  Enables the support for the digicolor timer driver.
 
 config DW_APB_TIMER
 	bool
-- 
1.9.1
