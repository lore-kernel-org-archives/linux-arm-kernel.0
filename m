From: enric.balletbo@collabora.com (Enric Balletbo i Serra)
Date: Mon,  2 Jul 2018 12:21:58 +0200
Subject: [PATCH 0/3] platform/chrome: mfd: Move cros-ec transport drivers to
 drivers/platform
Message-ID: <20180702102201.13461-1-enric.balletbo@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The cros-ec transport drivers are placed in two subsystems, in MFD and
in platform/chrome. As far as I know there is no reason for this, so,
move the I2C and the SPI cros-ec transport driver from the MFD subsystem
to the platform/chrome. The series also removes the MFD_ prefix for the
Kconfig symbols, modifies the defconfigs that used these symbols and
fixes the KEYBOARD_CROS_EC Kconfig help.

Best regards,
 Enric

Enric Balletbo i Serra (3):
  platform/chrome: Move cros-ec transport drivers to drivers/platform.
  arm/arm64: configs: Remove the MFD_ prefix for MFD_CROS_EC_I2C/SPI
    symbols.
  Input: keyboard: Fix ChromeOS EC keyboard help message.

 arch/arm/configs/exynos_defconfig             |  4 ++--
 arch/arm/configs/multi_v7_defconfig           |  4 ++--
 arch/arm/configs/pxa_defconfig                |  4 ++--
 arch/arm64/configs/defconfig                  |  4 ++--
 drivers/input/keyboard/Kconfig                |  2 +-
 drivers/mfd/Kconfig                           | 20 -------------------
 drivers/mfd/Makefile                          |  2 --
 drivers/platform/chrome/Kconfig               | 20 +++++++++++++++++++
 drivers/platform/chrome/Makefile              |  2 ++
 .../{mfd => platform/chrome}/cros_ec_i2c.c    |  0
 .../{mfd => platform/chrome}/cros_ec_spi.c    |  0
 11 files changed, 31 insertions(+), 31 deletions(-)
 rename drivers/{mfd => platform/chrome}/cros_ec_i2c.c (100%)
 rename drivers/{mfd => platform/chrome}/cros_ec_spi.c (100%)

-- 
2.18.0
