From: hong.xu@atmel.com (Hong Xu)
Date: Wed, 25 May 2011 14:03:27 +0800
Subject: [PATCH] AT91: Add VSYNC pin definition for AT91SAM9RL silicon
Message-ID: <1306303407-23659-1-git-send-email-hong.xu@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Atmel's AT91SAM9RL-EK board, the LCD panel does not need VSYNC
signal. But this signal is useful for the boards from other
vendors, as reported by Nicholas Kinar.
This small patch adds the VSYNC pin definition by default.

Reported-by: Nicholas Kinar <n.kinar@usask.ca>
Signed-off-by: Hong Xu <hong.xu@atmel.com>
---

 arch/arm/mach-at91/at91sam9rl_devices.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index c49262b..87a49d9 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -538,6 +538,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	}
 
 	at91_set_B_periph(AT91_PIN_PC1, 0);	/* LCDPWR */
+	at91_set_A_periph(AT91_PIN_PC4, 0);	/* LCDVSYNC */
 	at91_set_A_periph(AT91_PIN_PC5, 0);	/* LCDHSYNC */
 	at91_set_A_periph(AT91_PIN_PC6, 0);	/* LCDDOTCK */
 	at91_set_A_periph(AT91_PIN_PC7, 0);	/* LCDDEN */
-- 
1.7.3.3
