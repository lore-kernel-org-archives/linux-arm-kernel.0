From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Thu, 29 Sep 2016 18:31:49 +0200
Subject: [PATCH 0/6] ARM: davinci: da850-lcdk: add support for tilcdc
Message-ID: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series enables the tilcdc support for da850-lcdk. Besides the
device tree changes it contains some tweaks needed to make it work.

Tested with a da850-lcdk board with an LCD display connected over
VGA with the following modes:

  modetest -M tilcdc -s 26:800x600 at RG16
  modetest -M tilcdc -s 26:1024x768 at RG16

Rebased on top of some necessary changes in the tilcdc drm driver.
These changes will go upstream through the drm tree.

Bartosz Golaszewski (3):
  ARM: dts: da850-lcdk: add support for 1024x768 resolution
  ARM: davinci: enable the LCDC DRM driver in defconfig
  ARM: da850: adjust memory settings for tilcdc

Karl Beldan (3):
  ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for lcdc
  ARM: dts: da850: add a node for the LCD controller
  ARM: dts: da850-lcdk: enable the LCD controller

 arch/arm/boot/dts/da850-lcdk.dts           | 71 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/da850.dtsi               |  8 ++++
 arch/arm/configs/davinci_all_defconfig     |  2 +
 arch/arm/mach-davinci/da8xx-dt.c           | 44 ++++++++++++++++++
 arch/arm/mach-davinci/include/mach/da8xx.h |  4 ++
 5 files changed, 129 insertions(+)

-- 
2.7.4
