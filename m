From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 13 Nov 2014 17:15:37 +0100
Subject: [GIT PULL] ARM: tegra: Device tree fixes for v3.18-rc5
Message-ID: <20141113161530.GA3613@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-3.18-fixes-for-rc5

for you to fetch changes up to 221b9bf42b26a22e6904d20f35c53aec2e73a646:

  ARM: tegra: roth: Fix SD card VDD_IO regulator (2014-11-13 16:58:53 +0100)

Thierry

----------------------------------------------------------------
ARM: tegra: Device tree fixes for v3.18-rc5

This contains the serial port numbering fixes that are required for the
serial port numbering to stay the same with or without the serial core
making use of the aliases defined in DT.

eMMC is also fixed for TN7 and Roth boards which were using the wrong
regulators.

----------------------------------------------------------------
Alexandre Courbot (2):
      ARM: tegra: Remove eMMC vmmc property for roth/tn7
      ARM: tegra: roth: Fix SD card VDD_IO regulator

Lucas Stach (1):
      ARM: tegra: Add serial port labels to Tegra124 DT

Olof Johansson (1):
      ARM: dts: tegra: move serial aliases to per-board

 arch/arm/boot/dts/tegra114-dalmore.dts        | 1 +
 arch/arm/boot/dts/tegra114-roth.dts           | 9 +++++----
 arch/arm/boot/dts/tegra114-tn7.dts            | 5 ++++-
 arch/arm/boot/dts/tegra114.dtsi               | 7 -------
 arch/arm/boot/dts/tegra124-jetson-tk1.dts     | 1 +
 arch/arm/boot/dts/tegra124-nyan-big.dts       | 1 +
 arch/arm/boot/dts/tegra124-venice2.dts        | 1 +
 arch/arm/boot/dts/tegra124.dtsi               | 8 ++++----
 arch/arm/boot/dts/tegra20-harmony.dts         | 1 +
 arch/arm/boot/dts/tegra20-iris-512.dts        | 5 +++++
 arch/arm/boot/dts/tegra20-medcom-wide.dts     | 4 ++++
 arch/arm/boot/dts/tegra20-paz00.dts           | 2 ++
 arch/arm/boot/dts/tegra20-seaboard.dts        | 1 +
 arch/arm/boot/dts/tegra20-tamonten.dtsi       | 1 +
 arch/arm/boot/dts/tegra20-trimslice.dts       | 1 +
 arch/arm/boot/dts/tegra20-ventana.dts         | 1 +
 arch/arm/boot/dts/tegra20-whistler.dts        | 1 +
 arch/arm/boot/dts/tegra20.dtsi                | 8 --------
 arch/arm/boot/dts/tegra30-apalis-eval.dts     | 4 ++++
 arch/arm/boot/dts/tegra30-beaver.dts          | 1 +
 arch/arm/boot/dts/tegra30-cardhu.dtsi         | 2 ++
 arch/arm/boot/dts/tegra30-colibri-eval-v3.dts | 3 +++
 arch/arm/boot/dts/tegra30.dtsi                | 8 --------
 23 files changed, 44 insertions(+), 32 deletions(-)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/dc19ff2b/attachment-0001.sig>
