From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Jul 2013 09:34:20 +0900
Subject: [GIT 0/4] Renesas TPU PWM support for v3.12
Message-ID: <cover.1374624997.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider this pull request, which adds support for
the renesas TPU PWM unit, for v3.12.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-tpu-pwm-for-v3.12

for you to fetch changes up to ae3e4c277669e16093f0e71ca927cf33e7dde053:

  leds: Remove leds-renesas-tpu driver (2013-07-22 10:16:54 +0900)

----------------------------------------------------------------
Renesas TPU PWM support for v3.12

Add Renesas TPU PWM unit support

----------------------------------------------------------------
Laurent Pinchart (4):
      ARM: shmobile: armadillo800eva: Add backlight support
      ARM: shmobile: kota2: Use leds-pwm + pwm-rmob
      ARM: shmobile: sh73a0: Remove all GPIOs
      leds: Remove leds-renesas-tpu driver

 arch/arm/mach-shmobile/board-armadillo800eva.c |  54 +++-
 arch/arm/mach-shmobile/board-kota2.c           | 169 ++++++-----
 arch/arm/mach-shmobile/clock-sh73a0.c          |  12 +-
 arch/arm/mach-shmobile/include/mach/sh73a0.h   | 373 +------------------------
 drivers/leds/Kconfig                           |  12 -
 drivers/leds/Makefile                          |   1 -
 drivers/leds/leds-renesas-tpu.c                | 337 ----------------------
 include/linux/platform_data/leds-renesas-tpu.h |  14 -
 8 files changed, 143 insertions(+), 829 deletions(-)
 delete mode 100644 drivers/leds/leds-renesas-tpu.c
 delete mode 100644 include/linux/platform_data/leds-renesas-tpu.h
