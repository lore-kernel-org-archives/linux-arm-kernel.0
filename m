From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu,  2 Sep 2010 00:26:43 +0300
Subject: [PATCH v5 0/7] native wl1271 support on ZOOM
Message-ID: <1283376410-9999-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds wl1271 support on ZOOM2/3 boards.

Only basic support is included; MMC power manipulation part is submitted separately as Runtime PM migration.

Changes since v4:
- Introduce a simple (yet safe) mechanism to pass platform-specific data to the driver, as suggested by Russell King. Currently only a single device is supported; multi-device support will be introduced only when/if required

Patches are based on 2.6.36-rc3 and tested on ZOOM3.

Thanks,

Ohad Ben-Cohen (7):
  wireless: wl1271: make wl12xx.h common to both spi and sdio
  wireless: wl1271: support return value for the set power func
  wireless: wl12xx: add platform data passing support
  wireless: wl1271: take irq info from private board data
  wireless: wl1271: make ref_clock configurable by board
  omap: zoom: add fixed regulator device for wlan
  omap: zoom: add mmc3/wl1271 device support

 arch/arm/mach-omap2/board-zoom-peripherals.c       |   54 ++++++++++++++++++++
 drivers/net/wireless/Makefile                      |    2 +
 drivers/net/wireless/wl12xx/Kconfig                |    5 ++-
 drivers/net/wireless/wl12xx/wl1251_sdio.c          |    2 +-
 drivers/net/wireless/wl12xx/wl1251_spi.c           |    2 +-
 drivers/net/wireless/wl12xx/wl1271.h               |    3 +-
 drivers/net/wireless/wl12xx/wl1271_boot.c          |    9 ++--
 drivers/net/wireless/wl12xx/wl1271_boot.h          |    1 -
 drivers/net/wireless/wl12xx/wl1271_io.h            |    9 ++-
 drivers/net/wireless/wl12xx/wl1271_main.c          |    4 +-
 drivers/net/wireless/wl12xx/wl1271_sdio.c          |   19 ++++---
 drivers/net/wireless/wl12xx/wl1271_spi.c           |    8 ++-
 drivers/net/wireless/wl12xx/wl12xx_platform_data.c |   31 +++++++++++
 include/linux/spi/wl12xx.h                         |   34 ------------
 include/linux/wl12xx.h                             |   38 ++++++++++++++
 15 files changed, 164 insertions(+), 57 deletions(-)
 create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platform_data.c
 delete mode 100644 include/linux/spi/wl12xx.h
 create mode 100644 include/linux/wl12xx.h
