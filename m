From: alexander.stein@systec-electronic.com (Alexander Stein)
Date: Tue, 16 Nov 2010 12:17:32 +0100
Subject: clock enable for i.mx35 pwm
Message-ID: <201011161217.57831.alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I tried to use the PWM for activating a beeper. I noticed I had to write twice 
to the input device (pwm-beeper.c) to get a sound. I noticed the clock is 
enabled after the PWM is configured (or should be configured). So it seems 
while the clock is disabled, you can't program the PWM unit. So on pwm_request 
the clock should be enabled immediately and on pwm_enable the MX3_PWMCR_EN bit 
should be set (at least for i.mx > 2.1). No idea how to do that in the "older" 
variants.

Any opinions/fix about that?

Best regards,
Alexander
