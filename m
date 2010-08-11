From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 11 Aug 2010 21:21:45 +0300
Subject: [PATCH v4 0/8] native support for wl1271 on ZOOM
Message-ID: <1281550913-17633-1-git-send-email-ohad@wizery.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds native support for wl1271 on ZOOM.

Changes since v3:
- slot is marked nonremovable
- no explicit slot ocr mask
- dont split hsmmc mmc23 power control

Patches are based on linux-next (as of Aug 7th), and tested
on ZOOM2.

Please note that I am going to have a very limited email access
in the next three weeks, so I might not respond right away.

Thanks,

Ohad Ben-Cohen (8):
  wireless: wl1271: make wl12xx.h common to both spi and sdio
  wireless: wl1271: support return value for the set power func
  wireless: wl1271: add platform driver to get board data
  wireless: wl1271: take irq info from private board data
  wireless: wl1271: make ref_clock configurable by board
  omap: hsmmc: remove unused variable
  omap: zoom: add fixed regulator device for wlan
  omap: zoom: add mmc3/wl1271 device support

 arch/arm/mach-omap2/board-zoom-peripherals.c |   69 +++++++++++++++
 drivers/mmc/host/omap_hsmmc.c                |    1 -
 drivers/net/wireless/wl12xx/wl1251_sdio.c    |    2 +-
 drivers/net/wireless/wl12xx/wl1251_spi.c     |    2 +-
 drivers/net/wireless/wl12xx/wl1271.h         |   15 +++-
 drivers/net/wireless/wl12xx/wl1271_boot.c    |    9 +-
 drivers/net/wireless/wl12xx/wl1271_boot.h    |    1 -
 drivers/net/wireless/wl12xx/wl1271_io.h      |    8 +-
 drivers/net/wireless/wl12xx/wl1271_main.c    |    4 +-
 drivers/net/wireless/wl12xx/wl1271_sdio.c    |  120 +++++++++++++++++++++++---
 drivers/net/wireless/wl12xx/wl1271_spi.c     |    8 ++-
 include/linux/spi/wl12xx.h                   |   34 -------
 include/linux/wl12xx.h                       |   35 ++++++++
 13 files changed, 245 insertions(+), 63 deletions(-)
 delete mode 100644 include/linux/spi/wl12xx.h
 create mode 100644 include/linux/wl12xx.h
