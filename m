From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 28 Sep 2016 09:36:10 -0700
Subject: [GIT PULL] immutable branch to move HTC EGPIO from MFD to GPIO
Message-ID: <CACRpkdZBiQDpUuv9gsN2dhv0BBjPxpLC7Jz1R_zF7UjpHAXzeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here is an immutable branch for you Lee - may be of interest to ARM SoC
or others touching arch/arm/mach-sa1100 or mach-pxa etc as well:

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git
tags/ib-move-htc-egpio-mfd

for you to fetch changes up to 3c6e8d05d60d8106b5cdc730cf220b2a4b521b66:

  mfd/gpio: Move HTC GPIO driver to GPIO subsystem (2016-09-28 09:28:34 -0700)

----------------------------------------------------------------
Immutable branch to move the HTC EGPIO expande from MFD to GPIO

----------------------------------------------------------------
Linus Walleij (1):
      mfd/gpio: Move HTC GPIO driver to GPIO subsystem

 arch/arm/mach-pxa/hx4700.c                                        | 2 +-
 arch/arm/mach-pxa/magician.c                                      | 2 +-
 arch/arm/mach-sa1100/h3xxx.c                                      | 2 +-
 drivers/gpio/Kconfig                                              | 8 ++++++++
 drivers/gpio/Makefile                                             | 1 +
 drivers/{mfd/htc-egpio.c => gpio/gpio-htc-egpio.c}                | 2 +-
 drivers/mfd/Kconfig                                               | 8 --------
 drivers/mfd/Makefile                                              | 1 -
 include/linux/{mfd/htc-egpio.h => platform_data/gpio-htc-egpio.h} | 0
 9 files changed, 13 insertions(+), 13 deletions(-)
 rename drivers/{mfd/htc-egpio.c => gpio/gpio-htc-egpio.c} (99%)
 rename include/linux/{mfd/htc-egpio.h => platform_data/gpio-htc-egpio.h} (100%)
