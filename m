From: david@lechnology.com (David Lechner)
Date: Tue,  1 Aug 2017 17:11:46 -0500
Subject: [PATCH v2 0/4] Support for LEGO MINDSTORMS EV3 LCD display
Message-ID: <1501625510-16727-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The goal of this series is to get the built-in LCD of the LEGO MINDSTORMS EV3
working.

v2 changes:
* Wrote a new driver for ST7586 instead of combining it with existing drivers
* Don't touch MIPI DBI code (other than the patch suggested by Noralf)
* New defconfig patch


David Lechner (4):
  drm/tinydrm: remove call to mipi_dbi_init() from mipi_dbi_spi_init()
  drm/tinydrm: add support for LEGO MINDSTORMS EV3 LCD
  ARM: dts: da850-lego-ev3: Add node for LCD display
  ARM: davinci_all_defconfig: enable tinydrm and ST7586

 .../devicetree/bindings/display/st7586.txt         |  26 +
 arch/arm/boot/dts/da850-lego-ev3.dts               |  24 +
 arch/arm/configs/davinci_all_defconfig             |   2 +
 drivers/gpu/drm/tinydrm/Kconfig                    |  10 +
 drivers/gpu/drm/tinydrm/Makefile                   |   1 +
 drivers/gpu/drm/tinydrm/mi0283qt.c                 |   8 +-
 drivers/gpu/drm/tinydrm/mipi-dbi.c                 |  17 +-
 drivers/gpu/drm/tinydrm/st7586.c                   | 579 +++++++++++++++++++++
 include/drm/tinydrm/mipi-dbi.h                     |   6 +-
 include/drm/tinydrm/st7586.h                       |  34 ++
 10 files changed, 688 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/st7586.txt
 create mode 100644 drivers/gpu/drm/tinydrm/st7586.c
 create mode 100644 include/drm/tinydrm/st7586.h

-- 
2.7.4
