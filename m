From: tony@atomide.com (Tony Lindgren)
Date: Tue, 10 Nov 2009 19:01:23 -0800
Subject: [PATCH 5/8] omap3: beagle: Fix USB host port power control
In-Reply-To: <20091111025907.31793.84134.stgit@localhost>
References: <20091111025907.31793.84134.stgit@localhost>
Message-ID: <20091111030123.31793.40069.stgit@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jarkko Nikula <jhnikula@gmail.com>

The host port power is enabled by driving the nEN_USB_PWR low as stated in
the comment. This fix is originally from Steve Sakoman <steve@sakoman.com>.

Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
Cc: Steve Sakoman <steve@sakoman.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 70df6b4..08b0816 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -162,7 +162,7 @@ static int beagle_twl_gpio_setup(struct device *dev,
 
 	/* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active low) */
 	gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
-	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 1);
+	gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
 
 	/* TWL4030_GPIO_MAX + 1 == ledB, PMU_STAT (out, active low LED) */
 	gpio_leds[2].gpio = gpio + TWL4030_GPIO_MAX + 1;
