From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:25 +0100
Subject: [PATCH 12/69] clocksource/drivers/pxa_timer: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-12-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index d4221e0..e07ada9 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -307,7 +307,9 @@ config CLKSRC_TANGO_XTAL
 	select CLKSRC_OF
 
 config CLKSRC_PXA
-	bool
+	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
+	depends on GENERIC_CLOCKEVENTS
+	select CLKSRC_MMIO
 	help
 	  This enables OST0 support available on PXA and SA-11x0
 	  platforms.
-- 
1.9.1
