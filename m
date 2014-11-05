From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed,  5 Nov 2014 16:15:43 +0100
Subject: [PATCHv9 0/2] Add Allwinner SoCs PWM support
Message-ID: <1415200545-26238-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the PWM controller found on the Allwinner
SoCs.

The first patch adds the driver itself.
The second patch adds the DT binding documentation

Changes in v8:
 - renamed the driver sun4i as the PWM IP is different in the next sunxi SoCs
 - Took into account comments from Thierry

Changes in v9:
 - moved from using a mutex to a spinlock

Alexandre Belloni (2):
  pwm: Add Allwinner SoC support
  pwm: sunxi: document OF bindings

 .../devicetree/bindings/pwm/pwm-sun4i.txt          |  20 ++
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-sun4i.c                            | 366 +++++++++++++++++++++
 4 files changed, 396 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun4i.txt
 create mode 100644 drivers/pwm/pwm-sun4i.c

-- 
2.1.0
