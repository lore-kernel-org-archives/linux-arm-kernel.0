From: olof@lixom.net (Olof Johansson)
Date: Wed, 21 Dec 2011 11:15:07 -0800
Subject: [GIT PULL 5/5] Tegra driver updates for 3.3
Message-ID: <CAOesGMgFCiMqGMA4mVFxKT7tQ_OK+XbAgwXrnvWKp=N2LAouKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

Please pull the below driver updates for tegra for 3.3. They are two
device-tree-enablement related patches for i2c, I haven't seen acks
from Ben on them but they are trivial and tegra-specific patches so I
picked them up anyway.


Thanks,

-Olof


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
olof at quad:~/work/tegra (for-3.3/cleanup) $ git request-pull v3.2-rc5
git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git
for-3.3/driversThe following changes since commit
dc47ce90c3a822cd7c9e9339fe4d5f61dcb26b50:

  Linux 3.2-rc5 (2011-12-09 15:09:32 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/olof/tegra.git for-3.3/drivers

Stephen Warren (2):
      i2c: tegra: Add __devinit/exit to probe/remove
      i2c: tegra: Support DVC controller in device tree

 drivers/i2c/busses/i2c-tegra.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)
