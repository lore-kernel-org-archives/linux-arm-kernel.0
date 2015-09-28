From: petr.cvek@tul.cz (Petr Cvek)
Date: Mon, 28 Sep 2015 23:40:44 +0200
Subject: [PATCH v4 24/26] ARM: pxa: magician: Add debug message for backlight
 brightness function
In-Reply-To: <cover.1443472089.git.petr.cvek@tul.cz>
References: <cover.1443472089.git.petr.cvek@tul.cz>
Message-ID: <5609B3DC.90206@tul.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a debug message for the backlight brightness function.

Signed-off-by: Petr Cvek <petr.cvek@tul.cz>
---
 arch/arm/mach-pxa/magician.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index c89f2a8..5de33c6 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -437,6 +437,7 @@ static int magician_backlight_init(struct device *dev)
 
 static int magician_backlight_notify(struct device *dev, int brightness)
 {
+	pr_debug("Brightness = %i\n", brightness);
 	gpio_set_value(EGPIO_MAGICIAN_BL_POWER, brightness);
 	if (brightness >= 200) {
 		gpio_set_value(EGPIO_MAGICIAN_BL_POWER2, 1);
-- 
1.7.12.1
