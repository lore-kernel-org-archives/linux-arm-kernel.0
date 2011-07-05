From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 5 Jul 2011 10:40:58 +0530
Subject: [RFC/RFT 0/2] gpio: move tnetv107x gpio support to drivers/gpio
Message-ID: <cover.1309840042.git.nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series moves the tnetv107x GPIO support from
arch/arm/mach-davinci/ to drivers/gpio.

I do not have the tnetv107x EVM hardware so I have not been
able to test this. Any Tested-bys or Acked-bys are welcome
from those who have the hardware.

The patches apply to latest of gpio/next on Grant's tree.

Sekhar Nori (2):
  gpio/basic_mmio: add support for enable register
  davinci: use generic memory mapped gpio for tnetv107x

 arch/arm/mach-davinci/Kconfig             |    1 +
 arch/arm/mach-davinci/Makefile            |    1 -
 arch/arm/mach-davinci/devices-tnetv107x.c |   68 ++++++++++
 arch/arm/mach-davinci/gpio-tnetv107x.c    |  205 -----------------------------
 arch/arm/mach-davinci/tnetv107x.c         |    3 -
 drivers/gpio/gpio-ep93xx.c                |    2 +-
 drivers/gpio/gpio-generic.c               |   45 ++++++-
 drivers/gpio/gpio-mxc.c                   |    2 +-
 drivers/gpio/gpio-mxs.c                   |    2 +-
 include/linux/basic_mmio_gpio.h           |    5 +
 10 files changed, 121 insertions(+), 213 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/gpio-tnetv107x.c

-- 
1.7.3.2
