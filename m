From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 17 Sep 2014 21:53:56 +0200
Subject: [PATCHv7 0/2] Add Allwinner SoCs PWM support
Message-ID: <1410983638-24915-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the PWM controller found on the Allwinner
SoCs.

The first patch adds the driver itself.
The second patch adds the DT binding documentation

Changes in v7:
 - rebased on linux-pwm/for-next

Changes in v6:
 - Took into account comments from Thierry
 - Removed the prescaler bypass from sun4i (reported by Jon Smirl)
 - Rounding period half up when not using the prescaler (reported by Jon Smirl)
 - Corrected issues reported by Simon (PWM_PRD_MASK, channel 1 and off-by-one
   error)

Alexandre Belloni (2):
  pwm: Add Allwinner SoC support
  pwm: sunxi: document OF bindings

 .../devicetree/bindings/pwm/pwm-sunxi.txt          |  20 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sunxi.c                            | 371 +++++++++++++++++++++
 4 files changed, 401 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sunxi.txt
 create mode 100644 drivers/pwm/pwm-sunxi.c

-- 
1.9.1
