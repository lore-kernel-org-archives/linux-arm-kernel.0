From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Dec 2011 11:15:03 -0800
Subject: [GIT PULL 4/5] Tegra board updates for 3.3
Message-ID: <CAOesGMh7P6-=LbgUbYe1o7iO_-yALjce3H9ujXHW8hhikeTOsQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull the below board updates for tegra for the 3.3 merge window.

Some of the board changes went into the soc branch due to close
dependencies, most of these are pinmux cleanup and prep for pinctrl
integration.


They are based on the for-3.3/soc branch.


The following changes since commit 6cc04a4420391c3f034afe8ea6e28d75912a70a3:

  arm/tegra: Compile tegra_dt_init_irq only when CONFIG_OF (2011-12-19
18:07:22 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/boards

Leon Romanovsky (1):
      ARM: tegra: paz00: Fix board pinmux table.

Marc Dietrich (1):
      ARM: tegra: paz00: add support for wakeup gpio key

Olof Johansson (1):
      arm/tegra: remove __initdata annotation from pinmux tables

Stephen Warren (9):
      arm/tegra: Split Seaboard GPIO table to allow for Ventana
      arm/tegra: Add AUXDATA for tegra-pinmux and tegra-gpio
      arm/tegra: Harmony PCIe: Don't touch pinmux
      arm/tegra: PCIe: Remove include of mach/pinmux.h
      arm/tegra: Remove useless entries from ventana_pinmux[]
      arm/tegra: Rework Seaboard-vs-Ventana pinmux table
      arm/tegra: Fix mistake in Trimslice's pinmux
      arm/tegra: Refactor board-*-pinmux.c to share code
      arm/tegra: Use bus notifiers to trigger pinmux setup

 arch/arm/mach-tegra/Makefile                 |    1 +
 arch/arm/mach-tegra/board-dt.c               |   16 ++--
 arch/arm/mach-tegra/board-harmony-pcie.c     |    9 --
 arch/arm/mach-tegra/board-harmony-pinmux.c   |   22 ++---
 arch/arm/mach-tegra/board-paz00-pinmux.c     |   24 ++---
 arch/arm/mach-tegra/board-paz00.c            |   27 ++++++
 arch/arm/mach-tegra/board-paz00.h            |    3 +
 arch/arm/mach-tegra/board-pinmux.c           |  104 ++++++++++++++++++++++
 arch/arm/mach-tegra/board-pinmux.h           |   38 ++++++++
 arch/arm/mach-tegra/board-seaboard-pinmux.c  |  120 ++++++++++++--------------
 arch/arm/mach-tegra/board-trimslice-pinmux.c |   26 +++---
 arch/arm/mach-tegra/pcie.c                   |    1 -
 12 files changed, 269 insertions(+), 122 deletions(-)
 create mode 100644 arch/arm/mach-tegra/board-pinmux.c
 create mode 100644 arch/arm/mach-tegra/board-pinmux.h
