From: LW@KARO-electronics.de (=?UTF-8?q?Lothar=20Wa=C3=9Fmann?=)
Date: Fri, 10 Oct 2014 16:22:26 +0200
Subject: [PATCHv6 0/3] pwm: imx: support output polarity inversion
In-Reply-To: <20141009151605.GA8818@ulmo.nvidia.com>
References: <20141009151605.GA8818@ulmo.nvidia.com>
Message-ID: <1412950949-7505-1-git-send-email-LW@KARO-electronics.de>
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

Changes wrt. v5:
- don't remove of_pwm_n_cells to keep sanity checks for #pwm-cells as
  suggested by Thierry Reding
