From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon,  3 Nov 2014 19:12:03 +0100
Subject: [PATCH v3 0/4] regulator: Fix core behaviour for gpio 0,
 remaining patches
Message-ID: <1415038327-32616-1-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

here are the remaining patches of the series. Version 3 contains some fixes for
the first three patches. I added another patch which fixes a problem I noticed
in the tps65090 driver.

Changes in v3:
 - Moved the ena_gpio_initialized initialization out of the loop for s2m/s5m
   drivers.
 - Fixed a of_node check in max8952
 - Fixed ena_gpio_initialized for the 'fixed' regulator to only be set for
   gpios from DT


Best regards,

Markus


Markus Pargmann (4):
  regulator: Set ena_gpio_initialized in regulator drivers
  regulator: fixed: Use gpio_is_valid
  regulator: gpio: Use gpio_is_valid
  regulator: tps65090: Fix gpio initialization

 drivers/regulator/arizona-ldo1.c       | 2 ++
 drivers/regulator/fixed.c              | 5 ++++-
 drivers/regulator/gpio-regulator.c     | 4 +++-
 drivers/regulator/max8952.c            | 2 ++
 drivers/regulator/s2mps11.c            | 1 +
 drivers/regulator/s5m8767.c            | 1 +
 drivers/regulator/tps65090-regulator.c | 4 ++++
 drivers/regulator/wm8994-regulator.c   | 6 ++++--
 8 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.1.1
