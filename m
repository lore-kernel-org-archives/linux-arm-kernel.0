From: brgl@bgdev.pl (Bartosz Golaszewski)
Date: Tue, 13 Nov 2018 14:50:48 +0100
Subject: [PATCH 0/3] ARM: davinci: fix ethernet support on da850-evm
Message-ID: <20181113135051.15308-1-brgl@bgdev.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Ethernet doesn't work on da850-evm in legacy boot mode since v4.19. This
series addresses two problems I've found. I guess with this kind of
intrusive changes in the GPIO driver, other boards may be broken at the
moment too.

Bartosz Golaszewski (3):
  ARM: davinci: define gpio interrupts as separate resources
  gpio: davinci: restore a way to manually specify the GPIO base
  ARM: davinci: fix da850-evm boot in legacy mode

 arch/arm/mach-davinci/da850.c              |  4 ++-
 arch/arm/mach-davinci/devices-da8xx.c      | 42 +++++++++++++++++++++-
 drivers/gpio/gpio-davinci.c                |  2 +-
 include/linux/platform_data/gpio-davinci.h |  2 ++
 4 files changed, 47 insertions(+), 3 deletions(-)

-- 
2.19.1
