From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:18:09 +0100
Subject: [PATCH 56/69] clocksource/drivers/h8300: Increase the compilation
 test coverage
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-56-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the COMPILE_TEST option so the drivers can be compiled on different
architecture with the 'allyesconfig' kernel configuration.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 73477b5..db240cb 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -363,13 +363,24 @@ config CLKSRC_PXA
 	  platforms.
 
 config H8300_TMR8
-        bool
+        bool "Clockevent timer for the H8300 platform" if COMPILE_TEST
+        depends on GENERIC_CLOCKEVENTS
+	help
+	  This enables the 8 bits timer for the H8300 platform.
 
 config H8300_TMR16
-        bool
+        bool "Clockevent timer for the H83069 platform" if COMPILE_TEST
+        depends on GENERIC_CLOCKEVENTS
+	help
+	  This enables the 16 bits timer for the H8300 platform with the
+	  H83069 cpu.
 
 config H8300_TPU
-        bool
+        bool "Clocksource for the H8300 platform" if COMPILE_TEST
+        depends on GENERIC_CLOCKEVENTS
+	help
+	  This enables the clocksource for the H8300 platform with the
+	  H8S2678 cpu.
 
 config CLKSRC_IMX_GPT
 	bool "Clocksource using i.MX GPT" if COMPILE_TEST
-- 
1.9.1
