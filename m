From: lee.jones@linaro.org (Lee Jones)
Date: Wed,  9 Jan 2013 10:06:05 +0000
Subject: [PATCH 3/3] ARM: ux500: Add Snowball pin configuration for user LED
In-Reply-To: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
References: <1357725965-27342-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1357725965-27342-3-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here we setup the GPIO pin responsible for illuminating the user
LED on the Snowball low-cost development board.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/mach-ux500/board-mop500-pins.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-ux500/board-mop500-pins.c b/arch/arm/mach-ux500/board-mop500-pins.c
index 0a3f30d..d1a775c 100644
--- a/arch/arm/mach-ux500/board-mop500-pins.c
+++ b/arch/arm/mach-ux500/board-mop500-pins.c
@@ -747,6 +747,8 @@ static struct pinctrl_map __initdata snowball_pinmap[] = {
 	DB8500_PIN_HOG("GPIO21_AB3", out_hi),
 	/* Mux in "SM" which is used for the SMSC911x Ethernet adapter */
 	DB8500_MUX_HOG("sm_b_1", "sm"),
+	/* User LED */
+	DB8500_PIN_HOG("GPIO142_C11", gpio_out_hi),
 	/* Drive RSTn_LAN high */
 	DB8500_PIN_HOG("GPIO141_C12", gpio_out_hi),
 	/*  Accelerometer/Magnetometer */
-- 
1.7.9.5
