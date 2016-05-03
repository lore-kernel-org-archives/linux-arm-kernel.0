From: shawnguo@kernel.org (Shawn Guo)
Date: Tue,  3 May 2016 23:58:03 +0800
Subject: [GIT PULL 3/6] i.MX device tree updates for 4.7, take 2
In-Reply-To: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
References: <1462291086-19925-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1462291086-19925-3-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi arm-soc folks,

This is the second round of my imx/dt branch pull request.  It's based
on the first take [1], which has been pulled some days ago.

Please pull, thanks.

Shawn

[1] http://thread.gmane.org/gmane.linux.ports.arm.kernel/493365


The following changes since commit 880e1509db9732d5696d2a092e9bd61d80ad00be:

  ARM: dts: imx6qdl-udoo: add 7 inch LCD touchscreen panel support (2016-04-18 12:54:21 +0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt-4.7-2

for you to fetch changes up to 194521f72380d0e78caa71013e9e7de1703d8c85:

  ARM: mx5: dts: Enable USB OTG on M53EVK (2016-05-03 21:10:11 +0800)

----------------------------------------------------------------
The i.MX device tree updates for 4.7, take 2:
 - Update display clock configuration for imx6q-b850v3 board
 - Use watchdog external reset for imx6q-ba16 board
 - Update operating points settings for i.MX6UL/SX/DL
 - New board support: imx6ul-pico-hobbit and imx6q-marsboard
 - Add SAI audio support for imx6ul-14x14-evk board
 - Enable USB OTG support for M53EVK board
 - A couple of fixes on DTC warnings

----------------------------------------------------------------
Akshay Bhat (4):
      ARM: dts: imx6q-b850v3: Remove ldb panel
      ARM: dts: imx6q-b850v3: Update display clock source
      ARM: dts: imx: b450/b650v3: Move ldb_di clk assignment
      ARM: dts: imx6q-ba16: use wdog external reset

Fabio Estevam (9):
      ARM: dts: imx6ul: Fix operating points
      ARM: dts: imx6sx: Add 198MHz operating point
      ARM: dts: imx6dl: Fix the VDD_ARM_CAP voltage for 396MHz operation
      ARM: dts: imx6: Do not hardcode the CLKO clock
      ARM: dts: imx6ul-pico-hobbit: Add initial support
      ARM: dts: imx28-m28: Remove unneeded partition nodes
      ARM: dts: imx6sx-sdb: Add 198MHz operational point
      ARM: dts: imx6qdl: Remove unneeded unit-addresses
      ARM: dts: imx6ul-14x14-evk: Add audio support

Joshua Clayton (1):
      ARM: dts: imx6: fix dtc warnings for ipu endpoints

Marcel Ziswiler (1):
      ARM: dts: imx6: apalis: parallel lcd display support on ixora

Marek Vasut (1):
      ARM: mx5: dts: Enable USB OTG on M53EVK

Sergio Prado (1):
      ARM: dts: imx6: Add dts for Embest MarS Board

 arch/arm/boot/dts/Makefile                   |   2 +
 arch/arm/boot/dts/imx28-m28.dtsi             |  26 --
 arch/arm/boot/dts/imx53-m53evk.dts           |  21 +-
 arch/arm/boot/dts/imx6dl-riotboard.dts       |   2 +-
 arch/arm/boot/dts/imx6dl.dtsi                |   2 +-
 arch/arm/boot/dts/imx6q-apalis-ixora.dts     |  45 +++
 arch/arm/boot/dts/imx6q-b450v3.dts           |   5 +-
 arch/arm/boot/dts/imx6q-b650v3.dts           |   5 +-
 arch/arm/boot/dts/imx6q-b850v3.dts           |  33 +-
 arch/arm/boot/dts/imx6q-ba16.dtsi            |   1 +
 arch/arm/boot/dts/imx6q-gw5400-a.dts         |   2 +-
 arch/arm/boot/dts/imx6q-marsboard.dts        | 403 +++++++++++++++++++++
 arch/arm/boot/dts/imx6q-tbs2910.dts          |   2 +-
 arch/arm/boot/dts/imx6q.dtsi                 |  18 +-
 arch/arm/boot/dts/imx6qdl-apalis.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-apf6dev.dtsi       |   2 +-
 arch/arm/boot/dts/imx6qdl-gw52xx.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-gw53xx.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-gw54xx.dtsi        |   2 +-
 arch/arm/boot/dts/imx6qdl-nit6xlite.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6_max.dtsi |   2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi    |   2 +-
 arch/arm/boot/dts/imx6qdl-rex.dtsi           |   2 +-
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl-udoo.dtsi          |   2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi     |   2 +-
 arch/arm/boot/dts/imx6qdl.dtsi               |  32 +-
 arch/arm/boot/dts/imx6sx-sdb.dts             |   2 +
 arch/arm/boot/dts/imx6sx.dtsi                |   2 +
 arch/arm/boot/dts/imx6ul-14x14-evk.dts       |  74 ++++
 arch/arm/boot/dts/imx6ul-pico-hobbit.dts     | 516 +++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul.dtsi                |  12 +-
 32 files changed, 1130 insertions(+), 99 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6q-marsboard.dts
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-hobbit.dts
