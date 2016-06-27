From: slemieux.tyco@gmail.com (Sylvain Lemieux)
Date: Mon, 27 Jun 2016 09:09:54 -0400
Subject: [PATCH v2 0/3] pwm: lpc32xx: Add support to control PWM_PIN_LEVEL bit
Message-ID: <1467032997-5340-1-git-send-email-slemieux.tyco@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sylvain Lemieux <slemieux@tycoint.com>

The PWM_PIN_LEVEL bit is leave unset by the kernel PWM driver.

Prior to commit 08ee77b5a5de27ad63c92262ebcb4efe0da93b58,
the PWM_PIN_LEVEL bit was always clear when the PWM was disable
and a 0 logic level was apply to the output.

According to the LPC32x0 User Manual [1],
the default value for bit 30 (PWM_PIN_LEVEL) is 0.

First patch:
* initialize the pin level to 0 (default value) and update
  the register value accordingly.

Second anf third patches:
*  provide support to configure the pin output (i.e. PWM_PIN_LEVEL bit)
   when the PWM is disabled.

Note:
* Follow this URL to access the discussion for version 1 of this
  patch: http://thread.gmane.org/gmane.linux.pwm/3882

[1] http://www.nxp.com/documents/user_manual/UM10326.pdf

Sylvain Lemieux (3):
  pwm: lpc32xx: Set PWM_PIN_LEVEL bit to default value
  pwm: lpc32xx: Add support for PWM_PIN_LEVEL bit configuration
  dt-bindings: pwm: lpc32xx: Add nxp,pwm-disabled-level-high property

 Documentation/devicetree/bindings/pwm/lpc32xx-pwm.txt |  3 +++
 drivers/pwm/pwm-lpc32xx.c                             | 11 +++++++++++
 2 files changed, 14 insertions(+)

-- 
1.8.3.1
