From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Mon, 22 Feb 2016 19:37:49 +0530
Subject: [PATCH 00/61] gpio: Add and use devm_gpiochip_add_data()
Message-ID: <1456150130-2668-1-git-send-email-ldewangan@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add resource management APIs for gpiochip_add_data() and
gpiochip_remove() and use these APIs from different HW drivers.


This is based on discussion on patch to use the new APIs.
	gpio: Add devm_ apis for gpio_chip_add and remove

Laxman Dewangan (61):
  gpio: Add devm_ apis for gpiochip_add_data and gpiochip_remove
  gpio: Add resource management devm_gpio_chip_{add_data,remove}
  gpio: Add missing devm_gpio_ wrapper in devres.txt
  gpio: 74xx-mmio: Use devm_gpiochip_add_data() for gpio registration
  gpio: adnp: Use devm_gpiochip_add_data() for gpio registration
  gpio: adp5520: Use devm_gpiochip_add_data() for gpio registration
  gpio: adp5588: Use devm_gpiochip_add_data() for gpio registration
  gpio: amdpt: Use devm_gpiochip_add_data() for gpio registration
  gpio: arizona: Use devm_gpiochip_add_data() for gpio registration
  gpio: ath79: Use devm_gpiochip_add_data() for gpio registration
  gpio: bcm-kona: Use devm_gpiochip_add_data() for gpio registration
  gpio: clps711x: Use devm_gpiochip_add_data() for gpio registration
  gpio: crystalcove: Use devm_gpiochip_add_data() for gpio registration
  gpio: cs5535: Use devm_gpiochip_add_data() for gpio registration
  gpio: da9052: Use devm_gpiochip_add_data() for gpio registration
  gpio: da9055: Use devm_gpiochip_add_data() for gpio registration
  gpio: dln2: Use devm_gpiochip_add_data() for gpio registration
  gpio: ep93xx: Use devm_gpiochip_add_data() for gpio registration
  gpio: f7188x: Use devm_gpiochip_add_data() for gpio registration
  gpio: ge: Use devm_gpiochip_add_data() for gpio registration
  gpio: generic: Use devm_gpiochip_add_data() for gpio registration
  gpio: iop: Use devm_gpiochip_add_data() for gpio registration
  gpio: janz-ttl: Use devm_gpiochip_add_data() for gpio registration
  gpio: kempld: Use devm_gpiochip_add_data() for gpio registration
  gpio: lp3943: Use devm_gpiochip_add_data() for gpio registration
  gpio: lpc32xx: Use devm_gpiochip_add_data() for gpio registration
  gpio: lynxpoint: Use devm_gpiochip_add_data() for gpio registration
  gpio: mc9s08dz60: Use devm_gpiochip_add_data() for gpio registration
  gpio: moxart: Use devm_gpiochip_add_data() for gpio registration
  gpio: mvebu: Use devm_gpiochip_add_data() for gpio registration
  gpio: mxc: Use devm_gpiochip_add_data() for gpio registration
  gpio: octeon: Use devm_gpiochip_add_data() for gpio registration
  gpio: pca953x: Use devm_gpiochip_add_data() for gpio registration
  gpio: pcf857x: Use devm_gpiochip_add_data() for gpio registration
  gpio: palmas: Use devm_gpiochip_add_data() for gpio registration
  gpio: rc5t583: Use devm_gpiochip_add_data() for gpio registration
  gpio: rdc321x: Use devm_gpiochip_add_data() for gpio registration
  gpio: sch: Use devm_gpiochip_add_data() for gpio registration
  gpio: spear-spics: Use devm_gpiochip_add_data() for gpio registration
  gpio: sta2x11: Use devm_gpiochip_add_data() for gpio registration
  gpio: stp-xway: Use devm_gpiochip_add_data() for gpio registration
  gpio: sx150x: Use devm_gpiochip_add_data() for gpio registration
  gpio: syscon: Use devm_gpiochip_add_data() for gpio registration
  gpio: tb10x: Use devm_gpiochip_add_data() for gpio registration
  gpio: tc3589x: Use devm_gpiochip_add_data() for gpio registration
  gpio: tegra: Use devm_gpiochip_add_data() for gpio registration
  gpio: timberdale Use devm_gpiochip_add_data() for gpio registration
  gpio: tps6586x: Use devm_gpiochip_add_data() for gpio registration
  gpio: tps65910: Use devm_gpiochip_add_data() for gpio registration
  gpio: tps65912: Use devm_gpiochip_add_data() for gpio registration
  gpio: ts4800: Use devm_gpiochip_add_data() for gpio registration
  gpio: ts5500: Use devm_gpiochip_add_data() for gpio registration
  gpio: twl6040: Use devm_gpiochip_add_data() for gpio registration
  gpio: ucb1400: Use devm_gpiochip_add_data() for gpio registration
  gpio: viperboard: Use devm_gpiochip_add_data() for gpio registration
  gpio: vx855: Use devm_gpiochip_add_data() for gpio registration
  gpio: wm8350: Use devm_gpiochip_add_data() for gpio registration
  gpio: wm8350: Use devm_gpiochip_add_data() for gpio registration
  gpio: wm8994: Use devm_gpiochip_add_data() for gpio registration
  gpio: xgene-sb: Use devm_gpiochip_add_data() for gpio registration
  gpio: xgene: Use devm_gpiochip_add_data() for gpio registration

 Documentation/driver-model/devres.txt |  5 +++
 drivers/gpio/gpio-74xx-mmio.c         | 11 +-----
 drivers/gpio/gpio-adnp.c              | 11 +-----
 drivers/gpio/gpio-adp5520.c           | 13 +-----
 drivers/gpio/gpio-adp5588.c           |  4 +-
 drivers/gpio/gpio-amdpt.c             | 12 +-----
 drivers/gpio/gpio-arizona.c           | 12 +-----
 drivers/gpio/gpio-ath79.c             |  2 +-
 drivers/gpio/gpio-bcm-kona.c          |  2 +-
 drivers/gpio/gpio-clps711x.c          | 11 +-----
 drivers/gpio/gpio-crystalcove.c       |  9 +----
 drivers/gpio/gpio-cs5535.c            | 20 +++-------
 drivers/gpio/gpio-da9052.c            | 11 +-----
 drivers/gpio/gpio-da9055.c            | 16 +-------
 drivers/gpio/gpio-dln2.c              | 16 ++------
 drivers/gpio/gpio-ep93xx.c            |  2 +-
 drivers/gpio/gpio-f7188x.c            | 26 +-----------
 drivers/gpio/gpio-ge.c                |  2 +-
 drivers/gpio/gpio-generic.c           | 11 +-----
 drivers/gpio/gpio-iop.c               |  2 +-
 drivers/gpio/gpio-janz-ttl.c          | 12 +-----
 drivers/gpio/gpio-kempld.c            | 11 +-----
 drivers/gpio/gpio-lp3943.c            | 12 +-----
 drivers/gpio/gpio-lpc32xx.c           |  2 +-
 drivers/gpio/gpio-lynxpoint.c         |  4 +-
 drivers/gpio/gpio-mc9s08dz60.c        | 13 +-----
 drivers/gpio/gpio-moxart.c            |  2 +-
 drivers/gpio/gpio-mvebu.c             | 11 ++----
 drivers/gpio/gpio-mxc.c               |  6 +--
 drivers/gpio/gpio-octeon.c            | 10 +----
 drivers/gpio/gpio-palmas.c            | 12 +-----
 drivers/gpio/gpio-pca953x.c           |  4 +-
 drivers/gpio/gpio-pcf857x.c           | 10 ++---
 drivers/gpio/gpio-rc5t583.c           | 12 +-----
 drivers/gpio/gpio-rdc321x.c           | 13 +-----
 drivers/gpio/gpio-sch.c               | 11 +-----
 drivers/gpio/gpio-spear-spics.c       |  2 +-
 drivers/gpio/gpio-sta2x11.c           |  2 +-
 drivers/gpio/gpio-stp-xway.c          |  2 +-
 drivers/gpio/gpio-sx150x.c            | 18 +--------
 drivers/gpio/gpio-syscon.c            | 11 +-----
 drivers/gpio/gpio-tb10x.c             | 22 +++--------
 drivers/gpio/gpio-tc3589x.c           | 13 +-----
 drivers/gpio/gpio-tegra.c             |  2 +-
 drivers/gpio/gpio-timberdale.c        |  4 +-
 drivers/gpio/gpio-tps6586x.c          | 12 +-----
 drivers/gpio/gpio-tps65910.c          | 12 +-----
 drivers/gpio/gpio-tps65912.c          | 12 +-----
 drivers/gpio/gpio-ts4800.c            | 12 +-----
 drivers/gpio/gpio-ts5500.c            |  9 ++---
 drivers/gpio/gpio-twl6040.c           |  9 +----
 drivers/gpio/gpio-ucb1400.c           |  3 +-
 drivers/gpio/gpio-viperboard.c        | 24 ++----------
 drivers/gpio/gpio-vx855.c             | 12 +-----
 drivers/gpio/gpio-wm831x.c            | 12 +-----
 drivers/gpio/gpio-wm8350.c            | 12 +-----
 drivers/gpio/gpio-wm8994.c            | 17 ++------
 drivers/gpio/gpio-xgene-sb.c          |  3 +-
 drivers/gpio/gpio-xgene.c             | 11 +-----
 drivers/gpio/gpiolib.c                | 74 +++++++++++++++++++++++++++++++++++
 include/linux/gpio/driver.h           |  4 ++
 61 files changed, 180 insertions(+), 477 deletions(-)

-- 
2.1.4
