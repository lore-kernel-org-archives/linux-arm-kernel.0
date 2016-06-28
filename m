From: j-keerthy@ti.com (Keerthy)
Date: Tue, 28 Jun 2016 11:36:10 +0530
Subject: [PATCH v3 00/10] mfd: tps65218: Clean ups
Message-ID: <1467093980-11458-1-git-send-email-j-keerthy@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series cleans up mainly the regulator driver and implements
the device tree parsing using the regulator framework. Removes
all the redundant compatibles for the individual regulators.
Removes compatible for gpio driver as well and adds it to
the mfd_cell.

One of the patch removes redundant read wrapper and makes
use of regmap_read wherever necessary.

The series is checked for all the regulator registrations on
am437x-gp-evm and am437x-sk-evm.

Changes in v3:

Missed making corresponding changes in the power button and gpio
drivers. Added couple of patches to fix them to use mfd_cell way
of parsing.


Keerthy (10):
  mfd: tps65218: Remove redundant read wrapper
  Documentation: regulator: tps65218: Update examples
  input: tps65218-pwrbutton: Add platform_device_id table
  mfd: tps65218: Use mfd_add_devices instead of of_platform_populate
  regulator: tps65218: Remove all the compatibles
  gpio: tps65218: Remove the compatible
  ARM: dts: AM437X-GP-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-SK-EVM: Remove redundant regulator compatibles
  ARM: dts: AM437X-CM-T43: Remove redundant regulator compatibles
  ARM: dts: AM43X-EPOS-EVM: Remove redundant regulator compatibles

 .../devicetree/bindings/regulator/tps65218.txt     |  87 ++++++++++---
 arch/arm/boot/dts/am437x-cm-t43.dts                |   6 -
 arch/arm/boot/dts/am437x-gp-evm.dts                |   6 -
 arch/arm/boot/dts/am437x-sk-evm.dts                |   5 -
 arch/arm/boot/dts/am43x-epos-evm.dts               |   7 --
 drivers/gpio/gpio-tps65218.c                       |  13 +-
 drivers/input/misc/tps65218-pwrbutton.c            |  10 +-
 drivers/mfd/tps65218.c                             |  29 ++---
 drivers/regulator/tps65218-regulator.c             | 134 ++++++++-------------
 include/linux/mfd/tps65218.h                       |   2 -
 10 files changed, 147 insertions(+), 152 deletions(-)

-- 
1.9.1
