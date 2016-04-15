From: thierry.reding@gmail.com (Thierry Reding)
Date: Fri, 15 Apr 2016 16:42:02 +0200
Subject: [GIT PULL 2/3] ARM: tegra: Changes for v4.7-rc1
In-Reply-To: <1460731323-31001-1-git-send-email-thierry.reding@gmail.com>
References: <1460731323-31001-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <1460731323-31001-2-git-send-email-thierry.reding@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.7-arm

for you to fetch changes up to e7d9b2709ab04059b6a5f0ff016826dc4d4f96e4:

  ARM: tegra: Correct interrupt type for ARM TWD (2016-04-12 17:10:26 +0200)

Thanks,
Thierry

----------------------------------------------------------------
ARM: tegra: Changes for v4.7-rc1

A couple of patches that cleanup some Kconfig, enable various features,
use stdout-path to define the debug serial port (so that it doesn't have
to be manually specified on the kernel command-line) and cleanup and fix
some minor device trees bugs.

----------------------------------------------------------------
Jon Hunter (2):
      ARM: tegra: Add stdout-path for various boards
      ARM: tegra: Correct interrupt type for ARM TWD

Maarten Lankhorst (1):
      ARM: tegra: Enable watchdog support for Tegra114 and Tegra124

Masahiro Yamada (1):
      ARM: tegra: Remove redundant ARM_L1_CACHE_SHIFT_6 select

Ralf Ramsauer (2):
      ARM: tegra: Fix copy/paste typo in several DTS includes
      ARM: tegra: Add high speed UARTs to Jetson TK1 device tree

Sudeep Holla (1):
      ARM: tegra: Replace legacy *,wakeup property with wakeup-source

 arch/arm/boot/dts/tegra114-dalmore.dts        |  6 ++++-
 arch/arm/boot/dts/tegra114-roth.dts           |  2 +-
 arch/arm/boot/dts/tegra114-tn7.dts            |  2 +-
 arch/arm/boot/dts/tegra114.dtsi               |  4 ++--
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 32 ++++++++++++++++++++++++++-
 arch/arm/boot/dts/tegra124-nyan.dtsi          |  8 +++++--
 arch/arm/boot/dts/tegra124-venice2.dts        |  6 ++++-
 arch/arm/boot/dts/tegra124.dtsi               |  4 ++--
 arch/arm/boot/dts/tegra20-harmony.dts         |  6 ++++-
 arch/arm/boot/dts/tegra20-iris-512.dts        |  4 ++++
 arch/arm/boot/dts/tegra20-medcom-wide.dts     |  4 ++++
 arch/arm/boot/dts/tegra20-paz00.dts           |  6 ++++-
 arch/arm/boot/dts/tegra20-seaboard.dts        |  8 +++++--
 arch/arm/boot/dts/tegra20-tamonten.dtsi       |  4 ++++
 arch/arm/boot/dts/tegra20-trimslice.dts       |  6 ++++-
 arch/arm/boot/dts/tegra20-ventana.dts         |  6 ++++-
 arch/arm/boot/dts/tegra20-whistler.dts        |  6 ++++-
 arch/arm/boot/dts/tegra20.dtsi                |  4 ++--
 arch/arm/boot/dts/tegra30-apalis-eval.dts     |  6 ++++-
 arch/arm/boot/dts/tegra30-beaver.dts          |  4 ++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi         |  6 ++++-
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |  6 ++++-
 arch/arm/boot/dts/tegra30.dtsi                |  4 ++--
 drivers/soc/tegra/Kconfig                     |  2 --
 24 files changed, 119 insertions(+), 27 deletions(-)
