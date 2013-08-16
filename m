From: jason@lakedaemon.net (Jason Cooper)
Date: Fri, 16 Aug 2013 12:54:37 -0400
Subject: [GIT PULL v2] ARM: mvebu: DT changes for v3.12
In-Reply-To: <20130814201630.GH13964@titan.lakedaemon.net>
References: <20130814201630.GH13964@titan.lakedaemon.net>
Message-ID: <20130816165437.GT13964@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof,

I've dropped the mv64xxx-i2c change until Gregory reworks it.

thx,

Jason.

The following changes since commit 3b2f64d00c46e1e4e9bd0bb9bb12619adac27a4b:

  Linux 3.11-rc2 (2013-07-21 12:05:29 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/dt-3.12

for you to fetch changes up to 5d3b883071763e6448386b875f04fcb201b6e12d:

  ARM: mvebu: Fix the Armada 370/XP timer compatible strings (2013-08-16 13:02:11 +0000)

----------------------------------------------------------------
mvebu dt changes for v3.12

 - kirkwood
    - add ZyXEL NSA310 board, fan for ReadyNAS Duo v2

 - mvebu
    - add ReadyNAS 102 board

 - misc dts updates and changes.

v2:
 - dropped mv64xxx-i2c change

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: Add support for another ZyXEL NSA310 variant

Arnaud Ebalard (2):
      arm: kirkwood: readynas duo v2: Add GMT G762 Fan Controller
      ARM: mvebu: Add Netgear ReadyNAS 102 board

Ezequiel Garcia (1):
      ARM: mvebu: Fix the Armada 370/XP timer compatible strings

Jason Cooper (2):
      ARM: kirkwood: use dts pre-processor for nsa310 boards
      ARM: mvebu: use dts pre-processor for readynas 102

Thomas Petazzoni (1):
      ARM: mvebu: use correct #interrupt-cells instead of #interrupts-cells

 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts     | 179 +++++++++++++++++++++
 arch/arm/boot/dts/armada-370-xp.dtsi               |   2 -
 arch/arm/boot/dts/armada-370.dtsi                  |  11 +-
 arch/arm/boot/dts/armada-xp-mv78230.dtsi           |   4 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi           |   6 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi           |   6 +-
 arch/arm/boot/dts/armada-xp.dtsi                   |   2 +-
 .../boot/dts/kirkwood-netgear_readynas_duo_v2.dts  |  20 +++
 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi      | 107 ++++++++++++
 arch/arm/boot/dts/kirkwood-nsa310.dts              | 100 +-----------
 arch/arm/boot/dts/kirkwood-nsa310a.dts             | 165 +++++++++++++++++++
 12 files changed, 491 insertions(+), 113 deletions(-)
 create mode 100644 arch/arm/boot/dts/armada-370-netgear-rn102.dts
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310-common.dtsi
 create mode 100644 arch/arm/boot/dts/kirkwood-nsa310a.dts
