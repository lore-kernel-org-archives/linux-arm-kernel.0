From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu,  4 Apr 2013 19:28:57 -0600
Subject: [GIT PULL 2/3] ARM: bcm2835: convert to multi-platform
In-Reply-To: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
References: <1365125338-6668-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1365125338-6668-2-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch (patch) converts BCM2835 to support being built into a
multi-platform single zImage. This mostly entails a few small Kconfig
tweaks, move the earlyprintk implementation to the standard multi-
platform location, and deleting some unnecessary files.

----------------------------------------------------------------

The following changes since commit f6161aa153581da4a3867a2d1a7caf4be19b6ec9:

  Linux 3.9-rc2

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-rpi.git bcm2835-for-3.10-multiplatform

for you to fetch changes up to f1ac922dec7ed36659344eadc65b9c06efe14d7f:

  ARM: bcm2835: convert to multi-platform

----------------------------------------------------------------

Stephen Warren (1):
      ARM: bcm2835: convert to multi-platform

 arch/arm/Kconfig                                |   22 +--------
 arch/arm/Kconfig.debug                          |    5 ++
 arch/arm/configs/bcm2835_defconfig              |    2 +
 .../debug-macro.S => include/debug/bcm2835.S}   |    3 +-
 arch/arm/mach-bcm2835/Kconfig                   |   15 ++++++
 arch/arm/mach-bcm2835/Makefile.boot             |    1 -
 arch/arm/mach-bcm2835/bcm2835.c                 |    6 ++-
 .../arm/mach-bcm2835/include/mach/bcm2835_soc.h |   29 ------------
 arch/arm/mach-bcm2835/include/mach/gpio.h       |    1 -
 arch/arm/mach-bcm2835/include/mach/timex.h      |   26 -----------
 arch/arm/mach-bcm2835/include/mach/uncompress.h |   44 ------------------
 11 files changed, 30 insertions(+), 124 deletions(-)
 rename arch/arm/{mach-bcm2835/include/mach/debug-macro.S => include/debug/bcm2835.S} (86%)
 create mode 100644 arch/arm/mach-bcm2835/Kconfig
 delete mode 100644 arch/arm/mach-bcm2835/Makefile.boot
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/bcm2835_soc.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/gpio.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/timex.h
 delete mode 100644 arch/arm/mach-bcm2835/include/mach/uncompress.h
