From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 19 Oct 2011 18:18:52 +0200
Subject: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
In-Reply-To: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1319041134-19712-2-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/mach-at91/include/mach/board.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index ed544a0..adbc431 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -207,4 +207,12 @@ extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
 /* FIXME: this needs a better location, but gets stuff building again */
 extern int at91_suspend_entering_slow_clock(void);
 
+/* ADC */
+struct at91_adc_data {
+	unsigned int adc_clock;
+	u8 channels;
+	u8 startup_time;
+};
+extern void __init at91_add_device_adc(struct at91_adc_data *data);
+
 #endif
-- 
1.7.4.1
