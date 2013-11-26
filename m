From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 26 Nov 2013 19:44:18 +0000
Subject: [PATCH] Versatile LEDs initialise to off state
Message-ID: <20131126194418.GI16735@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There really is no excuse to turn on all 8 LEDs at boot time, such
that on the Versatile PB/926 we end up with 6 LEDs on continuously
and forever.  We're not a christmas decoration!

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-versatile/leds.c |    4 +-
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-versatile/leds.c b/arch/arm/plat-versatile/leds.c
index d2490d00b46c..c74aa5707dab 100644
--- a/arch/arm/plat-versatile/leds.c
+++ b/arch/arm/plat-versatile/leds.c
@@ -73,7 +73,7 @@ static int __init versatile_leds_init(void)
 {
 	int i;
 
-	/* All ON */
-	writel(0xff, LEDREG);
+	/* All off */
+	writel(0, LEDREG);
 	for (i = 0; i < ARRAY_SIZE(versatile_leds); i++) {
 		struct versatile_led *led;
 
