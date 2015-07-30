From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Thu, 30 Jul 2015 11:23:16 +0200
Subject: [PATCH v2 0/5] ARM: berlin: PWM support
Message-ID: <1438248201-29222-1-git-send-email-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series adds a driver for the Marvell Berlin PWM controller, which
has 4 channels.

This has been tested on a BG2Q DMP.

Thanks,

Antoine

Changes since v1:
	- Added a sentinel in berlin_pwm_match[]

Antoine Tenart (5):
  pwm: add the Berlin pwm controller driver
  Documentation: bindings: document the Berlin PWM driver
  ARM: berlin: add a PWM node on the BG2Q
  ARM: berlin: add a PWM node on the BG2
  ARM: berlin: add a PWM node on the BG2CD

 .../devicetree/bindings/pwm/pwm-berlin.txt         |  15 ++
 arch/arm/boot/dts/berlin2.dtsi                     |   6 +
 arch/arm/boot/dts/berlin2cd.dtsi                   |   6 +
 arch/arm/boot/dts/berlin2q.dtsi                    |   6 +
 drivers/pwm/Kconfig                                |   9 +
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/pwm-berlin.c                           | 207 +++++++++++++++++++++
 7 files changed, 250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pwm/pwm-berlin.txt
 create mode 100644 drivers/pwm/pwm-berlin.c

-- 
2.5.0
