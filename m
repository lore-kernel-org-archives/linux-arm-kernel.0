From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri,  1 Jul 2016 16:50:25 +0200
Subject: [GIT PULL 5/6] ARM: tegra: Changes for v4.8-rc1
In-Reply-To: <20160701145026.25760-1-thierry.reding@gmail.com>
References: <20160701145026.25760-1-thierry.reding@gmail.com>
Message-ID: <20160701145026.25760-5-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.8-arm

for you to fetch changes up to 1cedbdf624145076992c794ae07b85fe20063c1b:

  ARM: tegra: Initial support for Apalis TK1 (2016-07-01 16:34:16 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Changes for v4.8-rc1

Mostly cleanups, but also initial support for the Toradex Apalis TK1.

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: tegra: Remove board_init_funcs array

Marcel Ziswiler (2):
      ARM: tegra: Remove commas from unit addresses on Tegra124
      ARM: tegra: Initial support for Apalis TK1

Stephen Warren (1):
      ARM: tegra: Import latest Jetson TK1 spreadsheet

Thierry Reding (6):
      ARM: tegra: hotplug: Include missing common.h
      ARM: tegra: cpuidle: Add missing cpuidle.h include
      ARM: tegra: irq: Add missing irq.h include
      ARM: tegra: pm: Add tegra_cpu_do_idle() prototype
      ARM: tegra: Fix a couple of DTC warnings
      ARM: tegra: Add spaces around = in properties

 arch/arm/boot/dts/Makefile                     |    1 +
 arch/arm/boot/dts/tegra114-dalmore.dts         |    2 +-
 arch/arm/boot/dts/tegra114-roth.dts            |    4 +-
 arch/arm/boot/dts/tegra114-tn7.dts             |    2 +-
 arch/arm/boot/dts/tegra124-apalis-emc.dtsi     | 1502 +++++++++++++++++
 arch/arm/boot/dts/tegra124-apalis-eval.dts     |  284 ++++
 arch/arm/boot/dts/tegra124-apalis.dtsi         | 2100 ++++++++++++++++++++++++
 arch/arm/boot/dts/tegra124-jetson-tk1-emc.dtsi |    6 +-
 arch/arm/boot/dts/tegra124-jetson-tk1.dts      |   88 +-
 arch/arm/boot/dts/tegra124-nyan-big-emc.dtsi   |    6 +-
 arch/arm/boot/dts/tegra124-nyan-big.dts        |    4 +-
 arch/arm/boot/dts/tegra124-nyan-blaze-emc.dtsi |    6 +-
 arch/arm/boot/dts/tegra124-nyan-blaze.dts      |    2 +-
 arch/arm/boot/dts/tegra124-nyan.dtsi           |   60 +-
 arch/arm/boot/dts/tegra124-venice2.dts         |   70 +-
 arch/arm/boot/dts/tegra124.dtsi                |  125 +-
 arch/arm/boot/dts/tegra20-colibri-512.dtsi     |    2 +-
 arch/arm/boot/dts/tegra20-harmony.dts          |    2 +-
 arch/arm/boot/dts/tegra20-paz00.dts            |    2 +-
 arch/arm/boot/dts/tegra20-seaboard.dts         |    2 +-
 arch/arm/boot/dts/tegra20-tamonten.dtsi        |    2 +-
 arch/arm/boot/dts/tegra20-trimslice.dts        |    2 +-
 arch/arm/boot/dts/tegra20-ventana.dts          |    2 +-
 arch/arm/boot/dts/tegra20-whistler.dts         |    2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi          |    7 +-
 arch/arm/boot/dts/tegra30-beaver.dts           |    2 +-
 arch/arm/boot/dts/tegra30-cardhu.dtsi          |    2 +-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts  |    2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi         |    2 +-
 arch/arm/mach-tegra/common.h                   |   22 +
 arch/arm/mach-tegra/cpuidle-tegra114.c         |    1 +
 arch/arm/mach-tegra/cpuidle-tegra20.c          |    1 +
 arch/arm/mach-tegra/cpuidle-tegra30.c          |    1 +
 arch/arm/mach-tegra/cpuidle.h                  |    2 +
 arch/arm/mach-tegra/hotplug.c                  |    1 +
 arch/arm/mach-tegra/irq.c                      |    1 +
 arch/arm/mach-tegra/pm.h                       |    2 +-
 arch/arm/mach-tegra/tegra.c                    |   24 +-
 38 files changed, 4124 insertions(+), 224 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-emc.dtsi
 create mode 100644 arch/arm/boot/dts/tegra124-apalis-eval.dts
 create mode 100644 arch/arm/boot/dts/tegra124-apalis.dtsi
