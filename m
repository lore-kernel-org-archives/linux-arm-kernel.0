From: bhuvanchandra.dv@toradex.com (Bhuvanchandra DV)
Date: Sat, 1 Oct 2016 15:42:29 +0530
Subject: [PATCH v2 0/6] Support PWM polarity control
Message-ID: <20161001101235.24598-1-bhuvanchandra.dv@toradex.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:

- Picked the stalled patchset[1] from Lothar Wassmann which adds the basic
  support for polarity control on imx-pwm driver and adds backward compatibility
  support for devices which does not have polarity control feature.

Changes since Lothars v6:

- Squash Lukasz patch[2].

[1] http://thread.gmane.org/gmane.linux.pwm/1621
[2] https://www.spinics.net/lists/arm-kernel/msg530818.html

Bhuvanchandra DV (3):
  arm: dts: imx7: Update #pwm-cells for PWM polarity control
  arm: dts: imx7-colibri: Use pwm polarity control
  arm: dts: imx7-colibri: Use enable-gpios for BL_ON

Lothar Wassmann (3):
  pwm: print error messages with pr_err() instead of pr_debug()
  pwm: core: make the PWM_POLARITY flag in DTB optional
  pwm: imx: support output polarity inversion

 Documentation/devicetree/bindings/pwm/imx-pwm.txt |  6 +--
 arch/arm/boot/dts/imx7-colibri.dtsi               | 12 +++++-
 arch/arm/boot/dts/imx7s.dtsi                      |  8 ++--
 drivers/pwm/core.c                                | 31 ++++++++------
 drivers/pwm/pwm-imx.c                             | 51 +++++++++++++++++++++--
 5 files changed, 83 insertions(+), 25 deletions(-)

-- 
2.9.2
