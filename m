From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 14:06:18 -0600
Subject: [GIT PULL 07/10] ARM: tegra: device tree changes
In-Reply-To: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
References: <1347653181-19936-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1347653181-19936-7-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This branch adds two main features to Tegra boards, simply by amending
device tree files: regulator support and the ability to turn off system
power when executing "shutdown".

As part of these changes, the board file for Cardhu is split into two
versions, since different revisions have different hardware in some
areas, especially related to regulators.

This branch is based on v3.6-rc4.

----------------------------------------------------------------

The following changes since commit 4cbe5a555fa58a79b6ecbb6c531b8bab0650778d:

  Linux 3.6-rc4

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/swarren/linux-tegra.git tegra-for-3.7-dt

for you to fetch changes up to 44b12ef78106141574f038852d013fd3207acb23:

  ARM: dt: tegra: configure power off for some boards

----------------------------------------------------------------

Laxman Dewangan (3):
      ARM: dt: tegra: cardhu: add entry for PMIC TPS65911.
      ARM: dt: tegra: cardhu: split dts file for support multiple board versions
      ARM: tegra: cardhu: add dt entry for fixed regulators

Stephen Warren (5):
      ARM: dt: tegra: seaboard: add regulators
      ARM: dt: tegra: ventana: add regulators
      ARM: dt: tegra: paz00: add regulators
      ARM: dt: tegra: whistler: add regulators
      ARM: dt: tegra: configure power off for some boards

 arch/arm/boot/dts/tegra20-paz00.dts      |  173 +++++++++
 arch/arm/boot/dts/tegra20-seaboard.dts   |  186 ++++++++++
 arch/arm/boot/dts/tegra20-ventana.dts    |  206 +++++++++++
 arch/arm/boot/dts/tegra20-whistler.dts   |  293 +++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu-a02.dts |   87 +++++
 arch/arm/boot/dts/tegra30-cardhu-a04.dts |   98 +++++
 arch/arm/boot/dts/tegra30-cardhu.dts     |  171 ---------
 arch/arm/boot/dts/tegra30-cardhu.dtsi    |  475 +++++++++++++++++++++++++
 arch/arm/mach-tegra/Makefile.boot        |    3 +-
 9 files changed, 1520 insertions(+), 172 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra30-cardhu-a02.dts
 create mode 100644 arch/arm/boot/dts/tegra30-cardhu-a04.dts
 delete mode 100644 arch/arm/boot/dts/tegra30-cardhu.dts
 create mode 100644 arch/arm/boot/dts/tegra30-cardhu.dtsi
