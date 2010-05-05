From: valentin.longchamp@epfl.ch (Valentin Longchamp)
Date: Wed,  5 May 2010 11:34:21 +0200
Subject: [PATCH 1/1] mx31smartbot: change the config of a gpio
Message-ID: <1273052061-17147-1-git-send-email-valentin.longchamp@epfl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since it is finally used on the handbot as a configuration input for
the translator.

Signed-off-by: Valentin Longchamp <valentin.longchamp@epfl.ch>
---
 arch/arm/mach-mx3/mx31moboard-smartbot.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mx3/mx31moboard-smartbot.c b/arch/arm/mach-mx3/mx31moboard-smartbot.c
index 52a69fc..83d2b9f 100644
--- a/arch/arm/mach-mx3/mx31moboard-smartbot.c
+++ b/arch/arm/mach-mx3/mx31moboard-smartbot.c
@@ -119,7 +119,7 @@ static int __init smartbot_cam_init(void)
 #define POWER_EN IOMUX_TO_GPIO(MX31_PIN_DTR_DCE1)
 #define DSPIC_RST_B IOMUX_TO_GPIO(MX31_PIN_DSR_DCE1)
 #define TRSLAT_RST_B IOMUX_TO_GPIO(MX31_PIN_RI_DCE1)
-#define SEL3 IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)
+#define TRSLAT_SRC_CHOICE IOMUX_TO_GPIO(MX31_PIN_DCD_DCE1)
 
 static void smartbot_resets_init(void)
 {
@@ -138,9 +138,9 @@ static void smartbot_resets_init(void)
 		gpio_export(TRSLAT_RST_B, false);
 	}
 
-	if (!gpio_request(SEL3, "sel3")) {
-		gpio_direction_input(SEL3);
-		gpio_export(SEL3, true);
+	if (!gpio_request(TRSLAT_SRC_CHOICE, "translator-src-choice")) {
+		gpio_direction_output(TRSLAT_SRC_CHOICE, 0);
+		gpio_export(TRSLAT_SRC_CHOICE, false);
 	}
 }
 /*
-- 
1.7.0.4
