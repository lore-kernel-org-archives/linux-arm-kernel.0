From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 19 Jul 2013 13:34:48 +0900
Subject: [GIT 0/7] Renesas ARM and SH based SoC backlight drivers for v3.12
Message-ID: <cover.1374207161.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider the following backlight drivers for v3.12.

The following changes since commit ad81f0545ef01ea651886dddac4bef6cec930092:

  Linux 3.11-rc1 (2013-07-14 15:18:27 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-backlight-for-v3.12

for you to fetch changes up to 0fb19cdabfc3f8884bac53fd81b02bf61c7904af:

  ARM: mach-shmobile: ag5evm: Use bd6107 backlight driver (2013-07-17 10:06:18 +0900)

----------------------------------------------------------------
Renesas ARM and SH based SoC backlight drivers for v3.12

Backlight drivers used by SH and ARM SH-Mobile boards.

----------------------------------------------------------------
Laurent Pinchart (7):
      backlight: Add GPIO-based backlight driver
      backlight: Add Sanyo LV5207LP backlight driver
      backlight: Add ROHM BD6107 backlight driver
      ARM: mach-shmobile: mackerel: Use gpio-backlight
      sh: ecovec24: Use gpio-backlight
      sh: kfr2r09: Use lv5207lp backlight
      ARM: mach-shmobile: ag5evm: Use bd6107 backlight driver

 arch/arm/mach-shmobile/board-ag5evm.c        |   65 ++------
 arch/arm/mach-shmobile/board-mackerel.c      |   34 ++--
 arch/sh/boards/mach-ecovec24/setup.c         |   37 +++--
 arch/sh/boards/mach-kfr2r09/lcd_wqvga.c      |   48 ------
 arch/sh/boards/mach-kfr2r09/setup.c          |   19 ++-
 arch/sh/include/mach-kfr2r09/mach/kfr2r09.h  |    2 -
 drivers/video/backlight/Kconfig              |   19 +++
 drivers/video/backlight/Makefile             |    3 +
 drivers/video/backlight/bd6107.c             |  213 ++++++++++++++++++++++++++
 drivers/video/backlight/gpio_backlight.c     |  133 ++++++++++++++++
 drivers/video/backlight/lv5207lp.c           |  171 +++++++++++++++++++++
 include/linux/platform_data/bd6107.h         |   19 +++
 include/linux/platform_data/gpio_backlight.h |   21 +++
 include/linux/platform_data/lv5207lp.h       |   19 +++
 14 files changed, 665 insertions(+), 138 deletions(-)
 create mode 100644 drivers/video/backlight/bd6107.c
 create mode 100644 drivers/video/backlight/gpio_backlight.c
 create mode 100644 drivers/video/backlight/lv5207lp.c
 create mode 100644 include/linux/platform_data/bd6107.h
 create mode 100644 include/linux/platform_data/gpio_backlight.h
 create mode 100644 include/linux/platform_data/lv5207lp.h
