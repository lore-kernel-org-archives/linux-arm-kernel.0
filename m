From: tony@atomide.com (Tony Lindgren)
Date: Fri, 24 Sep 2010 17:27:13 -0700
Subject: [PATCH 4/7] omap: Beagle: no gpio_wp pin connection on xM
In-Reply-To: <20100925002608.24551.67183.stgit@baageli.muru.com>
References: <20100925002608.24551.67183.stgit@baageli.muru.com>
Message-ID: <20100925002713.24551.85624.stgit@baageli.muru.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Robert Nelson <robertcnelson@gmail.com>

The omap3630 based BeagleBoard xM uses a MicroSD card slot with
no write protection.

Signed-off-by: Robert Nelson <robertcnelson@gmail.com>
Acked-by: Jarkko Nikula <jhnikula@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 1908b33..5534841 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -272,7 +272,9 @@ static struct gpio_led gpio_leds[];
 static int beagle_twl_gpio_setup(struct device *dev,
 		unsigned gpio, unsigned ngpio)
 {
-	if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
+	if (omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_XM) {
+		mmc[0].gpio_wp = -EINVAL;
+	} else if ((omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C1_3) ||
 		(omap3_beagle_get_rev() == OMAP3BEAGLE_BOARD_C4)) {
 		omap_mux_init_gpio(23, OMAP_PIN_INPUT);
 		mmc[0].gpio_wp = 23;
