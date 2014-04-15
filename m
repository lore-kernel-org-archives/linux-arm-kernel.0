From: 21cnbao@gmail.com (Barry Song)
Date: Tue, 15 Apr 2014 14:43:45 +0800
Subject: [PATCH 0/4] pinctrl: sirf: switch to one gpiolib and gpiolib_irqchip
 helpers
Message-ID: <1397544229-20545-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

This patchset depends on Linus Walleij's "pinctrl: sirf: rename inlined accessor".
and "pinctrl: sirf: switch driver to use gpiolib irqchip helpers" is rebased
from Linus Walleij's patch too.

Barry Song (3):
  pinctrl: sirf: wrap all gpio banks into one gpio_chip
  gpio: make handler_data configurable while using gpiolib_irqchip
  pinctrl: sirf: move to use irq_get_handler_data
Linus Walleij (1):
  pinctrl: sirf: switch driver to use gpiolib irqchip helpers

 drivers/gpio/gpiolib.c              |   10 +-
 drivers/pinctrl/Kconfig             |    1 +
 drivers/pinctrl/sirf/pinctrl-sirf.c |  264 ++++++++++++-----------------------
 include/linux/gpio/driver.h         |    2 +-
 4 files changed, 97 insertions(+), 180 deletions(-)

-- 
1.7.5.4
