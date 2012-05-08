From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 08 May 2012 12:24:19 -0600
Subject: [GIT PULL] ARM: tegra: gpio-pinmux branch
Message-ID: <4FA964D3.9000001@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch is based on the following:

git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tag: pinctrl-mergebase-20120418
branch: devel or for-next
commit: dcb5dbc305b975cccf40942feba40964069541d3

It also forms the basis for many other Tegra pull requests to follow.

The following changes since commit dcb5dbc305b975cccf40942feba40964069541d3:
  Dong Aisheng (1):
        pinctrl: show pin name for pingroups in sysfs

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git
for-3.5/gpio-pinmux

Stephen Warren (12):
      usb: ehci-tegra: Add vbus_gpio to platform data
      ARM: tegra: Remove VBUS_GPIO handling from board files
      gpio: tegra: configure pins during irq_set_type
      ARM: tegra: seaboard: Don't gpio_request() ISL29018_IRQ
      gpio: tegra: Hide tegra_gpio_enable/disable()
      ARM: tegra: Switch to new pinctrl driver
      ARM: tegra: Remove pre-pinctrl pinmux driver
      ARM: dt: tegra cardhu: add pinmux to device tree
      ARM: dt: tegra20: add pinmux to device tree
      pinctrl: tegra: refactor probe handling
      pinctrl: tegra: debugfs enhancements
      pinctrl: tegra: error reporting cleanup

 arch/arm/boot/dts/tegra-cardhu.dts                |   44 +
 arch/arm/boot/dts/tegra-harmony.dts               |  224 +++++
 arch/arm/boot/dts/tegra-paz00.dts                 |  220 +++++
 arch/arm/boot/dts/tegra-seaboard.dts              |  243 +++++
 arch/arm/boot/dts/tegra-trimslice.dts             |  230 +++++
 arch/arm/boot/dts/tegra-ventana.dts               |  230 +++++
 arch/arm/mach-tegra/Makefile                      |    3 -
 arch/arm/mach-tegra/board-dt-tegra20.c            |   31 -
 arch/arm/mach-tegra/board-harmony-pinmux.c        |  266 +++---
 arch/arm/mach-tegra/board-paz00-pinmux.c          |  263 +++---
 arch/arm/mach-tegra/board-pinmux.c                |  105 +--
 arch/arm/mach-tegra/board-pinmux.h                |   40 +-
 arch/arm/mach-tegra/board-seaboard-pinmux.c       |  346 ++++----
 arch/arm/mach-tegra/board-seaboard.c              |   21 +-
 arch/arm/mach-tegra/board-trimslice-pinmux.c      |  264 +++---
 arch/arm/mach-tegra/board-trimslice.c             |   15 +-
 arch/arm/mach-tegra/devices.c                     |    5 +-
 arch/arm/mach-tegra/include/mach/gpio-tegra.h     |    9 -
 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h |  184 ----
 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h |  320 -------
 arch/arm/mach-tegra/include/mach/pinmux.h         |  302 -------
 arch/arm/mach-tegra/pinmux-tegra20-tables.c       |  244 -----
 arch/arm/mach-tegra/pinmux-tegra30-tables.c       |  376 --------
 arch/arm/mach-tegra/pinmux.c                      |  987
---------------------
 arch/arm/mach-tegra/usb_phy.c                     |    1 -
 drivers/gpio/gpio-tegra.c                         |   39 +-
 drivers/mmc/host/sdhci-tegra.c                    |   24 +-
 drivers/pinctrl/pinctrl-tegra.c                   |  236 +++---
 drivers/pinctrl/pinctrl-tegra.h                   |   23 +-
 drivers/pinctrl/pinctrl-tegra20.c                 |   40 +-
 drivers/pinctrl/pinctrl-tegra30.c                 |   40 +-
 drivers/usb/host/ehci-tegra.c                     |   13 +-
 include/linux/platform_data/tegra_usb.h           |    1 +
 33 files changed, 2055 insertions(+), 3334 deletions(-)
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra20.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux-tegra30.h
 delete mode 100644 arch/arm/mach-tegra/include/mach/pinmux.h
 delete mode 100644 arch/arm/mach-tegra/pinmux-tegra20-tables.c
 delete mode 100644 arch/arm/mach-tegra/pinmux-tegra30-tables.c
 delete mode 100644 arch/arm/mach-tegra/pinmux.c
