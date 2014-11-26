From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 26 Nov 2014 00:29:20 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.19 (round 2)
Message-ID: <20141126052920.GW22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Folks,

Here's a round of changes for v3.19.  All except for the top two commits
have been in -next for several days.

This is an incremental pull request from tags/mvebu-dt-3.19 up
tags/mvebu-dt-3.19-2 on the mvebu/dt branch.

Please pull.

thx,

Jason.


The following changes since commit f5ed9ccc4c2dc275a13b765c88fa13211f60b57f:

  ARM: mvebu: armada-xp: Fix 74hc595 count for Lenovo ix4-300d (2014-11-02 18:59:10 +0000)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.19-2

for you to fetch changes up to 70ee4e9d9f054e258480fd51c90cfc2b72be8b78:

  arm: mvebu: normalize pinctrl entries for Armada SoCs (2014-11-26 04:05:05 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.19 (round 2)

 - mvebu
    - Use simple-card audio on Armada 370 DB
    - Add DSA node for Armada 370 DB
    - Add SDHCI to Armada 38x
    - Armada 370/XP rework to support new Synology boards
    - Add Synology DS213j and DS414
    - Various pinctrl and uart and alias fixes to help bootloaders

----------------------------------------------------------------
Andrew Lunn (1):
      mvebu: 370 RD: Add support for the switch

Arnaud Ebalard (12):
      arm: mvebu: fix vendor prefix typo in kirkwood-synology.dtsi
      arm: mvebu: add uartX labels for Armada SoC serial nodes
      arm: mvebu: use recently introduced uart label for stdout-path
      arm: mvebu: move Armada 370/XP pinctrl node definition armada-370-xp.dtsi
      arm: mvebu: define and use common Armada 370 SPI pinctrl settings
      arm: mvebu: define and use common Armada 370 UART pinctrl settings
      arm: mvebu: define and use common Armada XP UART2/3 pinctrl settings
      arm: mvebu: define and use common Armada XP SPI pinctrl setting
      arm: mvebu: add .dts file for Synology DS213j
      arm: mvebu: add .dts file for Synology DS414
      arm: mvebu: fix wrongly named DS414 pinctrl entries
      arm: mvebu: normalize pinctrl entries for Armada SoCs

Marcin Wojtas (3):
      ARM: mvebu: enable no-1-8-v flag for Armada 385 DB SDHCI interface
      ARM: mvebu: remove clock-frequency from Armada 38x SDHCI Device Tree node
      ARM: mvebu: adjust ethernet aliases according to U-Boot requirements for A38x

Thomas Petazzoni (2):
      ARM: mvebu: remove conflicting muxing on Armada 370 DB
      ARM: mvebu: use simple-card DT binding for audio on Armada 370 DB

Uwe Kleine-K?nig (1):
      ARM: mvebu: fix ordering in Armada 370 .dtsi

 arch/arm/boot/dts/Makefile                       |   6 +-
 arch/arm/boot/dts/armada-370-db.dts              | 106 +++++---
 arch/arm/boot/dts/armada-370-mirabox.dts         |  25 +-
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   |  84 +++---
 arch/arm/boot/dts/armada-370-netgear-rn104.dts   |  64 ++---
 arch/arm/boot/dts/armada-370-rd.dts              |  73 +++--
 arch/arm/boot/dts/armada-370-synology-ds213j.dts | 316 ++++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi             |  11 +-
 arch/arm/boot/dts/armada-370.dtsi                | 189 ++++++++-----
 arch/arm/boot/dts/armada-385-db.dts              |   2 +-
 arch/arm/boot/dts/armada-38x.dtsi                |   6 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |  19 +-
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |   6 +-
 arch/arm/boot/dts/armada-xp-synology-ds414.dts   | 330 +++++++++++++++++++++++
 arch/arm/boot/dts/armada-xp.dtsi                 | 102 ++++---
 arch/arm/boot/dts/kirkwood-synology.dtsi         |   2 +-
 16 files changed, 1077 insertions(+), 264 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-synology-ds213j.dts
 create mode 100644 arch/arm/boot/dts/armada-xp-synology-ds414.dts
