From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 28 Nov 2011 21:37:14 +0800
Subject: [PATCH 0/5] Add device tree support for mc13892 regulator driver
Message-ID: <1322487439-27254-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch adds device tree probe support for mc13xxx mfd driver.

The patches #2 and #3 make small changes to regulator OF function for
supporting the case like mc13892 regulator driver, where device_node
does not have a struct device behind it.  I'm sorry for that I did not
notice them until I start porting mc13892 to the support

The patch #4 adds the actual device tree support for mc13892 regulator
driver, and the last patch add mc13892 support into imx51-babbage
device tree source.

Shawn Guo (5):
      mfd: mc13xxx: add device tree probe support
      regulator: fix label names used in device tree bindings
      regulator: pass device_node to of_get_regulator_init_data()
      regulator: mc13892: add device tree probe support
      arm/imx: add mc13892 support into imx51-babbage.dts

 .../devicetree/bindings/regulator/regulator.txt    |   10 +-
 arch/arm/boot/dts/imx51-babbage.dts                |  100 ++++++++++++++++-
 drivers/mfd/mc13xxx-core.c                         |  121 ++++++++++++++-----
 drivers/regulator/mc13892-regulator.c              |   43 +++++--
 drivers/regulator/mc13xxx-regulator-core.c         |   57 +++++++++
 drivers/regulator/mc13xxx.h                        |   20 ++++
 drivers/regulator/of_regulator.c                   |    7 +-
 include/linux/mfd/mc13xxx.h                        |    1 +
 include/linux/regulator/of_regulator.h             |    6 +-
 9 files changed, 311 insertions(+), 54 deletions(-)
