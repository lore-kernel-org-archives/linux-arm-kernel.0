From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Tue,  7 Oct 2014 15:55:31 +0200
Subject: [PATCHv4 0/3] pwm: imx: support output polarity inversion
Message-ID: <1412690134-13712-1-git-send-email-LW@KARO-electronics.de>
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

Changes wrt. v4:
- rebased onto current linux-next
- dropped cleanup patch which is not necessary any more
- resent with ACK from Shawn Guo and Reviewed-By tag from Sascha Hauer
