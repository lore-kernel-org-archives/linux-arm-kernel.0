From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 18 Dec 2015 15:17:22 +0100
Subject: [PATCH 09/69] clocksource/drivers/st_lpc: Fix Kconfig dependency
In-Reply-To: <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
References: <5672CB9E.7090707@linaro.org>
 <1450448302-27429-1-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <1450448302-27429-9-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the Kconfig selection rule by letting the STI arch to select
the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/mach-sti/Kconfig   | 1 +
 drivers/clocksource/Kconfig | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-sti/Kconfig b/arch/arm/mach-sti/Kconfig
index 125865d..12dd1dc 100644
--- a/arch/arm/mach-sti/Kconfig
+++ b/arch/arm/mach-sti/Kconfig
@@ -3,6 +3,7 @@ menuconfig ARCH_STI
 	select ARM_GIC
 	select ST_IRQCHIP
 	select ARM_GLOBAL_TIMER
+	select CLKSRC_ST_LPC
 	select PINCTRL
 	select PINCTRL_ST
 	select MFD_SYSCON
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index b423785..3594a2b 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -326,7 +326,6 @@ config CLKSRC_IMX_GPT
 
 config CLKSRC_ST_LPC
 	bool
-	depends on ARCH_STI
 	select CLKSRC_OF if OF
 	help
 	  Enable this option to use the Low Power controller timer
-- 
1.9.1
