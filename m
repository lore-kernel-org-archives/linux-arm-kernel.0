From: ccross@google.com (Colin Cross)
Date: Wed, 23 Mar 2011 15:25:07 -0700
Subject: ARM Tegra updates for 2.6.39
Message-ID: <AANLkTiko8EkxhsdmJPNWfrecxRY4ibmbp_3UeHirTOs4@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,
Please pull updates for Tegra from:

 git://android.git.kernel.org/kernel/tegra.git for-linus

These are changes that depended on the i2c and asoc trees that have
already been merged.

Thanks,
Colin

The following changes since commit c871fe663a6368fd0e98f5a3bfd81b0b9c591266:

  Merge branch 'for-2639/i2c/i2c-tegra' of
git://git.fluff.org/bjdooks/linux into for-next-i2c (2011-03-03
14:17:49 -0800)

are available in the git repository at:

  git://android.git.kernel.org/kernel/tegra.git for-linus

Colin Cross (1):
      Merge branch 'boards-for-next' of
git://git.kernel.org/.../olof/tegra-2.6 into for-next

Marc Dietrich (1):
      ARM: tegra: Add Toshiba AC100 support

Mike Rapoport (4):
      ARM: tegra: trimslice: enable MMC/SD slots
      ARM: tegra: harmony: update PCI-e initialization sequence
      ARM: tegra: update defconfig
      ARM: tegra: harmony: initialize the TPS65862 PMIC

Olof Johansson (4):
      ARM: tegra: seaboard: register i2c devices
      ARM: tegra: harmony: register i2c devices
      ARM: tegra: enable new drivers in defconfig
      Merge branch 'trimslice/upstream' of
git://git.kernel.org/.../rppt/linux-tegra into boards-for-next

Stephen Warren (5):
      ARM: tegra: add devices.c entries for audio
      ARM: tegra: create defines for SD-related GPIO names
      ARM: tegra: harmony: Beginnings of audio support
      ARM: tegra: harmony: I2C-related portions of audio support
      ARM: tegra: harmony: Set WM8903 gpio_base

 arch/arm/configs/tegra_defconfig             |   29 +++++-
 arch/arm/mach-tegra/Kconfig                  |    5 +
 arch/arm/mach-tegra/Makefile                 |    4 +
 arch/arm/mach-tegra/board-harmony-pcie.c     |   24 ++++-
 arch/arm/mach-tegra/board-harmony-pinmux.c   |   28 +++--
 arch/arm/mach-tegra/board-harmony-power.c    |  117 +++++++++++++++++++
 arch/arm/mach-tegra/board-harmony.c          |   95 +++++++++++++++-
 arch/arm/mach-tegra/board-harmony.h          |   15 +++
 arch/arm/mach-tegra/board-paz00-pinmux.c     |  157 ++++++++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.c            |  128 +++++++++++++++++++++
 arch/arm/mach-tegra/board-paz00.h            |   29 +++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |   11 +-
 arch/arm/mach-tegra/board-seaboard.c         |   68 ++++++++++-
 arch/arm/mach-tegra/board-seaboard.h         |    3 +
 arch/arm/mach-tegra/board-trimslice-pinmux.c |    9 ++
 arch/arm/mach-tegra/board-trimslice.c        |   19 +++
 arch/arm/mach-tegra/board-trimslice.h        |    3 +
 arch/arm/mach-tegra/devices.c                |   70 ++++++++++++
 arch/arm/mach-tegra/devices.h                |    4 +
 arch/arm/mach-tegra/include/mach/iomap.h     |    3 +
 20 files changed, 787 insertions(+), 34 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-harmony-power.c
 create mode 100644 arch/arm/mach-tegra/board-paz00-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.c
 create mode 100644 arch/arm/mach-tegra/board-paz00.h
