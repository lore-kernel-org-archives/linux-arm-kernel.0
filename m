From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 12 Dec 2011 23:15:55 +0800
Subject: [PATCH v3 0/3] Add device tree support for mc13892 regulator driver
Message-ID: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v2:
 * Drop '[PATCH v2 2/4] regulator: pass device_node to
   of_get_regulator_init_data()' which has been picked up by Mark
 * Add a note on how driver matches regulator device and the node in
   binding document

Changes since v1:
 * Drop '[PATCH 2/5] regulator: fix label names used in device tree
   bindings' which has been picked up
 * Add binding document for mfd/mc13xxx-core device tree support
 * Fix regulator/fixed.c breakage caused by interface change on
   of_get_regulator_init_data()
 * Reword the commit message of patch #2 a little bit to make the
   reason for changing clear
 * Retrieve the irq from gpio irq domain

Shawn Guo (3):
      mfd: mc13xxx: add device tree probe support
      regulator: mc13892: add device tree probe support
      arm/imx: add mc13892 support into imx51-babbage.dts

 Documentation/devicetree/bindings/mfd/mc13xxx.txt |   53 ++++++++++
 arch/arm/boot/dts/imx51-babbage.dts               |  103 ++++++++++++++++++++-
 drivers/mfd/mc13xxx-core.c                        |  106 +++++++++++++++------
 drivers/regulator/mc13892-regulator.c             |   43 ++++++--
 drivers/regulator/mc13xxx-regulator-core.c        |   57 +++++++++++
 drivers/regulator/mc13xxx.h                       |   20 ++++
 include/linux/mfd/mc13xxx.h                       |    1 +
 7 files changed, 339 insertions(+), 44 deletions(-)
