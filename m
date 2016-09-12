From: kraxel@redhat.com (Gerd Hoffmann)
Date: Mon, 12 Sep 2016 10:22:50 +0200
Subject: [PATCH v2 0/6] ARM: dts: bcm283x: add and use pinctrl groups
Message-ID: <1473668576-22256-1-git-send-email-kraxel@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

  Hi,

Next round:  Patch 1 is new and adds the pull defines to the device tree
bindings.  Patch 2 adds all the pinctrl groups, in a single patch now,
list sorting caused too many conflicts.  Patch 3-6 put some pinctrl
groups into use, they are unmodified (patches 5-8 in v1).

cheers,
  Gerd

Eric Anholt (1):
  ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.

Gerd Hoffmann (5):
  pinctrl: bcm2835: add pull defines to dt bindings
  ARM: dts: bcm283x: add pinctrl group to &pwm, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c0, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &i2c1, drop pins from &gpio
  ARM: dts: bcm283x: add pinctrl group to &sdhci, drop pins from &gpio

 arch/arm/boot/dts/bcm2835-rpi.dtsi    |  12 +-
 arch/arm/boot/dts/bcm283x.dtsi        | 203 ++++++++++++++++++++++++++++++++++
 drivers/pinctrl/bcm/pinctrl-bcm2835.c |   6 -
 include/dt-bindings/pinctrl/bcm2835.h |   5 +
 4 files changed, 218 insertions(+), 8 deletions(-)

-- 
1.8.3.1
