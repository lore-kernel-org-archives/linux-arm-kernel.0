From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 17 Oct 2013 13:07:59 -0600
Subject: [GIT PULL 4/6] ARM: tegra: device tree changes for 3.13
In-Reply-To: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
References: <1382036881-23339-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1382036881-23339-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* The initial device trees are added for the Tegra124 SoC and Venice2
  board which uses it.
* A few devices are added to the Dalmore and Cardhu DTs.
* The Dalmore board file is converted to use defines for keycodes.
* A couple small changes are made to graphics-related nodes on Tegra30.

This branch is based on v3.12-rc1.

----------------------------------------------------------------

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tegra-for-3.13-dt

for you to fetch changes up to c71d39090eae67c324a870f3c0d26347db504705:

  ARM: tegra: Use symbolic names for gr3d clocks

----------------------------------------------------------------

Joseph Lo (4):
      ARM: tegra: Add initial device tree for Tegra124
      ARM: tegra: add Venice2 board support
      ARM: tegra: enable Tegra RTC as default for Tegra124
      ARM: tegra: enable LP1 suspend mode for Venice2

Laxman Dewangan (2):
      ARM: tegra: add palmas pincontrol to Dalmore device tree
      ARM: tegra: use dt-binding header for key code

Stephen Warren (1):
      ARM: tegra: add GPIO controller to tegra124.dtsi

Thierry Reding (2):
      ARM: tegra: Mark Tegra30 display controller compatible with Tegra20
      ARM: tegra: Use symbolic names for gr3d clocks

Wei Ni (2):
      ARM: tegra: add DT entry for nct1008 to Dalmore
      ARM: tegra: add vcc supply for nct1008 to Cardhu

 arch/arm/boot/dts/Makefile             |   3 +-
 arch/arm/boot/dts/tegra114-dalmore.dts |  32 +++++-
 arch/arm/boot/dts/tegra124-venice2.dts |  27 +++++
 arch/arm/boot/dts/tegra124.dtsi        | 149 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi  |   3 +-
 arch/arm/boot/dts/tegra30.dtsi         |   5 +-
 6 files changed, 210 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/tegra124-venice2.dts
 create mode 100644 arch/arm/boot/dts/tegra124.dtsi
