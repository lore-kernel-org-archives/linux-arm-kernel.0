From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 9 Nov 2014 02:07:03 -0500
Subject: [GIT PULL] ARM: mvebu: DT changes for v3.19
Message-ID: <20141109070703.GY3698@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Here's a round of DT changes that have been in -next for at least 4
cycles.

Please pull.

thx,

Jason.


The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-dt-3.19

for you to fetch changes up to f5ed9ccc4c2dc275a13b765c88fa13211f60b57f:

  ARM: mvebu: armada-xp: Fix 74hc595 count for Lenovo ix4-300d (2014-11-02 18:59:10 +0000)

----------------------------------------------------------------
mvebu DT changes for v3.19

 - mvebu
    - ReadyNAS 102 leds, esata
    - ReadyNAS 2120 esata
    - Add cache-unified for Aurora L2 node
    - Add ref clk for timer and watchdog on Armada 375
    - Cleanup Armada XP pinctrl for GigE
    - Add RGMII pinctrl, i2c eeprom, and fix 74hc595 counter on Lenovo ix4-300d

 - kirkwood
    - Add DLink DIR665 and it's DSA configuration

----------------------------------------------------------------
Andrew Lunn (1):
      ARM: Kirkwood: DIR665: Instantiate Distributed Switch Architecture

Arnaud Ebalard (3):
      arm: mvebu: Fix LED color in NETGEAR ReadyNAS 102 .dts file
      arm: mvebu: Clarify (e)SATA ports info in NETGEAR ReadyNAS 102 .dts file
      ARM: mvebu: Enable rear eSATA ports of NETGEAR ReadyNAS 2120

Claudio Leite (1):
      ARM: Kirkwood: Add support for DLink DIR665

Ezequiel Garcia (1):
      ARM: mvebu: Enable the reference clock for timer and watchdog on Armada 375 SoC

Gregory CLEMENT (1):
      ARM: mvebu: Fix the Aurora L2 cache node with the required cache-unified property

Sebastian Hesselbarth (8):
      ARM: mvebu: armada-xp: Consolidate pinctrl node
      ARM: mvebu: armada-xp: Add node alias to pinctrl and add base address
      ARM: mvebu: armada-xp: Use pinctrl node alias
      ARM: mvebu: armada-xp: Move GE0/1 pinctrl settings for RGMII
      ARM: mvebu: armada-xp: Add GE0 pinctrl settings for GMII
      ARM: mvebu: armada-xp: Add RGMII pinctrl to Lenovo ix4-300d
      ARM: mvebu: armada-xp: Add I2C eeprom on Lenovo ix4-300d
      ARM: mvebu: armada-xp: Fix 74hc595 count for Lenovo ix4-300d

 arch/arm/boot/dts/Makefile                       |   1 +
 arch/arm/boot/dts/armada-370-netgear-rn102.dts   |  17 +-
 arch/arm/boot/dts/armada-370.dtsi                |   1 +
 arch/arm/boot/dts/armada-375.dtsi                |  12 +-
 arch/arm/boot/dts/armada-xp-axpwifiap.dts        |  58 ++---
 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts  |  73 +++---
 arch/arm/boot/dts/armada-xp-mv78230.dtsi         |  15 +-
 arch/arm/boot/dts/armada-xp-mv78260.dtsi         |  15 +-
 arch/arm/boot/dts/armada-xp-mv78460.dtsi         |  15 +-
 arch/arm/boot/dts/armada-xp-netgear-rn2120.dts   | 166 +++++++-------
 arch/arm/boot/dts/armada-xp-openblocks-ax3-4.dts |  14 +-
 arch/arm/boot/dts/armada-xp.dtsi                 |  38 ++++
 arch/arm/boot/dts/kirkwood-dir665.dts            | 278 +++++++++++++++++++++++
 13 files changed, 506 insertions(+), 197 deletions(-)
 create mode 100644 arch/arm/boot/dts/kirkwood-dir665.dts
