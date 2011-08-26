From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 26 Aug 2011 16:22:01 -0300
Subject: [PATCH 4/5] ARM: mx53: Allow gpio_keys to wake the system
In-Reply-To: <1314386521-29351-4-git-send-email-fabio.estevam@freescale.com>
References: <1314386521-29351-1-git-send-email-fabio.estevam@freescale.com>
	<1314386521-29351-2-git-send-email-fabio.estevam@freescale.com>
	<1314386521-29351-3-git-send-email-fabio.estevam@freescale.com>
	<1314386521-29351-4-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1314386521-29351-5-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allow KEY_HOME on mx53ard and KEY_POWER on mx53loco to generate a wakeup event.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/mach-mx5/board-mx53_ard.c  |    2 +-
 arch/arm/mach-mx5/board-mx53_loco.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mx5/board-mx53_ard.c b/arch/arm/mach-mx5/board-mx53_ard.c
index ddc3015..40ea3b7 100644
--- a/arch/arm/mach-mx5/board-mx53_ard.c
+++ b/arch/arm/mach-mx5/board-mx53_ard.c
@@ -115,7 +115,7 @@ static iomux_v3_cfg_t mx53_ard_pads[] = {
 }
 
 static struct gpio_keys_button ard_buttons[] = {
-	GPIO_BUTTON(ARD_HOME, KEY_HOME, 1, "home", 0),
+	GPIO_BUTTON(ARD_HOME, KEY_HOME, 1, "home", 1),
 	GPIO_BUTTON(ARD_BACK, KEY_BACK, 1, "back", 0),
 	GPIO_BUTTON(ARD_PROG, KEY_PROGRAM, 1, "program", 0),
 	GPIO_BUTTON(ARD_VOLUMEUP, KEY_VOLUMEUP, 1, "volume-up", 0),
diff --git a/arch/arm/mach-mx5/board-mx53_loco.c b/arch/arm/mach-mx5/board-mx53_loco.c
index 1bb0b3c..6529bde 100644
--- a/arch/arm/mach-mx5/board-mx53_loco.c
+++ b/arch/arm/mach-mx5/board-mx53_loco.c
@@ -204,7 +204,7 @@ static iomux_v3_cfg_t mx53_loco_pads[] = {
 }
 
 static struct gpio_keys_button loco_buttons[] = {
-	GPIO_BUTTON(MX53_LOCO_POWER, KEY_POWER, 1, "power", 0),
+	GPIO_BUTTON(MX53_LOCO_POWER, KEY_POWER, 1, "power", 1),
 	GPIO_BUTTON(MX53_LOCO_UI1, KEY_VOLUMEUP, 1, "volume-up", 0),
 	GPIO_BUTTON(MX53_LOCO_UI2, KEY_VOLUMEDOWN, 1, "volume-down", 0),
 };
-- 
1.6.0.4
