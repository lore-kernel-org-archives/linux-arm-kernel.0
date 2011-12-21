From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 21 Dec 2011 23:00:43 +0800
Subject: [PATCH v4 0/4] Add device tree support for mc13892 regulator driver
Message-ID: <1324479647-4580-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v3:
 * The mfd patch in v3 was applied, and it's replaced by a incremental
   patch to improve the binding document in the new series.
 * Add a patch to remove the unnecessary prefix 'MC13892__' from
   regulator name.
 * Adopt the binding and regulator name changes in dts.

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

Shawn Guo (4):
      mfd: improve mc13xxx dt binding document
      regulator: mc13892: remove the unnecessary prefix from regulator name
      regulator: mc13892: add device tree probe support
      arm/imx: add mc13892 support into imx51-babbage.dts

 Documentation/devicetree/bindings/mfd/mc13xxx.txt |   31 ++++++-
 arch/arm/boot/dts/imx51-babbage.dts               |   93 ++++++++++++++++++++-
 drivers/regulator/mc13892-regulator.c             |   43 +++++++---
 drivers/regulator/mc13xxx-regulator-core.c        |   57 +++++++++++++
 drivers/regulator/mc13xxx.h                       |   26 +++++-
 include/linux/mfd/mc13xxx.h                       |    1 +
 6 files changed, 232 insertions(+), 19 deletions(-)
