From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Thu, 12 Jun 2014 14:52:44 +0200
Subject: [PATCHv4 0/4] pwm: imx: support output polarity inversion
Message-ID: <1402577568-10037-1-git-send-email-LW@KARO-electronics.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for polarity inversion to the pwm-imx
driver. The patches have been tested on i.MX6, i.MX53 and with the
ti-ehrpwm.c driver.

Changes wrt. v2:
- make the use of '#pwm-cells = <3>' optional, so that the change does
  not break existing DT blobs as suggested by Arnd Bergmann and Sascha
  Hauer.

Changes wrt. v3:
- implemented the approach suggested by Sascha Hauer 
- don't modify struct pwm_ops in the imx_pwm probe function
