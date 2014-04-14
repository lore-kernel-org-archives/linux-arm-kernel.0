From: mporter@linaro.org (Matt Porter)
Date: Mon, 14 Apr 2014 14:50:24 -0400
Subject: [PATCH 0/4] Support additional regulators on BCM590xx
Message-ID: <1397501428-8857-1-git-send-email-mporter@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables support for 7 additional regulators on the BCM59056
PMU. These regulators are accessed via a secondary I2C slave address.
The MFD driver exposes an additional regmap descriptor for the additional
address space and the regulator implements support for GPLDO1-6 and VBUS
regulators.

Matt Porter (4):
  mfd: bcm590xx: update binding with additional BCM59056 regulators
  mfd: bcm590xx: add support for second i2c slave address space
  regulator: bcm590xx: add support for regulators on secondary i2c slave
  ARM: dts: bcm590xx: add support for GPLDO and VBUS regulators

 Documentation/devicetree/bindings/mfd/bcm590xx.txt |  4 +-
 arch/arm/boot/dts/bcm59056.dtsi                    | 21 +++++
 drivers/mfd/bcm590xx.c                             | 60 ++++++++++----
 drivers/regulator/bcm590xx-regulator.c             | 92 +++++++++++++++++++---
 include/linux/mfd/bcm590xx.h                       |  9 ++-
 5 files changed, 158 insertions(+), 28 deletions(-)

-- 
1.8.4
