From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:43 +0100
Subject: [PATCH 30/69] clocksource/drivers/nomadik_mtu: Add the COMPILE_TEST
 option
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-30-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Increase the compilation test coverage by adding the COMPILE_TEST option.

Due to the non portable code for the delay timer, this option is only
available for the ARM architecture.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index ed7a824..847b3b1 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -108,8 +108,8 @@ config ASM9260_TIMER
 	  Enables support for the ASM9260 timer.
 
 config CLKSRC_NOMADIK_MTU
-	bool
-	depends on (ARCH_NOMADIK || ARCH_U8500)
+	bool "Nomakdik clocksource driver" if COMPILE_TEST
+	depends on ARM
 	select CLKSRC_MMIO
 	help
 	  Support for Multi Timer Unit. MTU provides access
-- 
1.9.1
