From: marvin24@gmx.de (Marc Dietrich)
Date: Mon,  7 Mar 2011 21:01:30 +0100
Subject: [PATCH v2 0/2] ARM: tegra: Add Toshiba AC100 support
Message-ID: <cover.1299526691.git.marvin24@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add initial support for the Toshiba AC100 / Dynabook AZ netbook.
The code will not be able to boot the machine as the proprietary bootloader
uses a different machine type (V1 bl: tegra_generic, V2 bl: harmony). Support
for u-boot is being worked on.

The patches are intended for 2.6.40. Depending on the review (and community
progress), I hope to be able to submit more hardware support patches.

Marc Dietrich (2):
  Add initial support for the Toshiba AC100/Dynabook AZ netbook
  Add PAZ00 to tegra_defconfig

 arch/arm/configs/tegra_defconfig         |    1 +
 arch/arm/mach-tegra/Kconfig              |    5 +
 arch/arm/mach-tegra/Makefile             |    3 +
 arch/arm/mach-tegra/board-paz00-pinmux.c |  157 ++++++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.c        |  128 ++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h        |   29 ++++++
 6 files changed, 323 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.h
