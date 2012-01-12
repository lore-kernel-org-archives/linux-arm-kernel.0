From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Thu, 12 Jan 2012 13:13:29 +0530
Subject: [PATCH v2 0/2] Add lcd driver for panels with gpio controlled panel
 reset
Message-ID: <1326354211-27064-1-git-send-email-thomas.abraham@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changes since v1:
- Fixed gpio leak, added MODULE_DEVICE_TABLE and dev_pm_ops.
- Changed device tree bindings.

This patchset adds support for passive panels that do not use a nRESET line
which is controlled by a GPIO of the host system and which do not use a
serial comamnd interface (i2c or spi) or memory-mapped-io interface.

The first patch adds driver for passive raster-type lcd's with gpio controlled
panel reset. It includes support for both dt and non-dt platforms. The second
patch adds support for using this driver on Origen board.

Thomas Abraham (2):
  backlight: lcd: add driver for raster-type lcd's with gpio controlled panel reset
  ARM: Exynos: Use lcd power control driver for lcd panel

 .../devicetree/bindings/lcd/lcd-pwrctrl.txt        |   48 ++++
 arch/arm/mach-exynos/mach-origen.c                 |   29 +--
 drivers/video/backlight/Kconfig                    |    7 +
 drivers/video/backlight/Makefile                   |    1 +
 drivers/video/backlight/lcd_pwrctrl.c              |  232 ++++++++++++++++++++
 include/video/lcd_pwrctrl.h                        |   34 +++
 6 files changed, 328 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/lcd/lcd-pwrctrl.txt
 create mode 100644 drivers/video/backlight/lcd_pwrctrl.c
 create mode 100644 include/video/lcd_pwrctrl.h
