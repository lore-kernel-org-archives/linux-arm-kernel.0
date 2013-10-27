From: sre@debian.org (Sebastian Reichel)
Date: Sun, 27 Oct 2013 17:14:25 +0100
Subject: [PATCH 0/4] wl1251 device tree support
Message-ID: <1382890469-25286-1-git-send-email-sre@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The following patchset adds device tree support to
the spi variant of the wl1251 driver.

Some notes:

The first patch is from Luciano's wilink DT support
patchset [0].

The third patch (vio regulator support) is optional. N900's
wifi also worked without this patch, but its probably cleaner
to have it.

The patchset has been tested using DT boot with the Nokia N900
and connecting to my wlan access point.

[0] https://lkml.org/lkml/2013/7/3/333

-- Sebastian

Luciano Coelho (1):
  wl1251: split wl251 platform data to a separate structure

Sebastian Reichel (3):
  wl1251: move power GPIO handling into the driver
  wl1251: spi: add vio regulator support
  wl1251: spi: add device tree support

 .../devicetree/bindings/net/wireless/ti,wl1251.txt | 36 +++++++++++
 arch/arm/mach-omap2/board-omap3pandora.c           |  6 +-
 arch/arm/mach-omap2/board-rx51-peripherals.c       | 15 ++---
 drivers/net/wireless/ti/wilink_platform_data.c     | 37 +++++++++--
 drivers/net/wireless/ti/wl1251/sdio.c              | 31 +++++++---
 drivers/net/wireless/ti/wl1251/spi.c               | 71 ++++++++++++++++------
 drivers/net/wireless/ti/wl1251/wl1251.h            |  4 +-
 include/linux/wl12xx.h                             | 24 +++++++-
 8 files changed, 175 insertions(+), 49 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,wl1251.txt

-- 
1.8.4.rc3
