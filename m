From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Thu, 16 Sep 2010 01:22:02 +0200
Subject: [PATCH v6 0/7] native wl1271 support on ZOOM
Message-ID: <1284592929-29616-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds wl1271 support on ZOOM2/3 boards.

Only basic support is included; power manipulation is submitted separately as SDIO Runtime PM support.

Changes since v5:
- rebase to wireless-testing
- remove 2nd copy from wl12xx_platform_data (keep the 1st one though)

Thanks,

Ohad Ben-Cohen (7):
  wl12xx: make wl12xx.h common to both spi and sdio
  wl1271: propagate set_power's return value
  wl12xx: add platform data passing support
  wl1271: take irq info from private board data
  wl1271: make ref_clock configurable by board
  omap: zoom: add fixed regulator device for wlan
  omap: zoom: add mmc3/wl1271 device support

 arch/arm/mach-omap2/board-zoom-peripherals.c       |   54 ++++++++++++++++++++
 drivers/net/wireless/Makefile                      |    2 +
 drivers/net/wireless/wl12xx/Kconfig                |    5 ++-
 drivers/net/wireless/wl12xx/wl1251_sdio.c          |    2 +-
 drivers/net/wireless/wl12xx/wl1251_spi.c           |    2 +-
 drivers/net/wireless/wl12xx/wl1271.h               |    3 +-
 drivers/net/wireless/wl12xx/wl1271_boot.c          |   11 +++--
 drivers/net/wireless/wl12xx/wl1271_boot.h          |    1 -
 drivers/net/wireless/wl12xx/wl1271_io.h            |    9 ++-
 drivers/net/wireless/wl12xx/wl1271_main.c          |    4 +-
 drivers/net/wireless/wl12xx/wl1271_sdio.c          |   31 +++++++-----
 drivers/net/wireless/wl12xx/wl1271_spi.c           |    8 ++-
 drivers/net/wireless/wl12xx/wl12xx_platform_data.c |   28 ++++++++++
 include/linux/spi/wl12xx.h                         |   34 ------------
 include/linux/wl12xx.h                             |   38 ++++++++++++++
 15 files changed, 170 insertions(+), 62 deletions(-)
 create mode 100644 drivers/net/wireless/wl12xx/wl12xx_platform_data.c
 delete mode 100644 include/linux/spi/wl12xx.h
 create mode 100644 include/linux/wl12xx.h
