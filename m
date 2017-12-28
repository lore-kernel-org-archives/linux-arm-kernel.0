From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Wed, 27 Dec 2017 18:07:50 -0800
Subject: [GIT PULL 1/3] ARM: Keystone DTS for 4.16
Message-ID: <1514426872-5769-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4fbd8d194f06c8a3fd2af1ce560ddb31f7ec8323:

  Linux 4.15-rc1 (2017-11-26 16:01:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.16

for you to fetch changes up to 4fe85b0cdd06f8fef2631923799bdc95380badb5:

  ARM: dts: keystone-k2l-clocks: Add missing unit name to clock nodes that have regs (2017-12-16 14:36:57 -0800)

----------------------------------------------------------------
ARM: Keystone DTS update for 4.16

 - Enable GPIO bank2 for K2L
 - Enable QSPI for K2G & K2G-EVM
 - Enable UART1/2 for K2G & K2G-EVM
 - Enable peripherals for K2G-ICE
 - Fix C1 and C2 DTS warnings

----------------------------------------------------------------
Franklin S Cooper Jr (2):
      ARM: dts: k2g: Add UART 1 and 2 instances
      ARM: dts: k2g-evm: Enable UART 2

Javier Martinez Canillas (1):
      ARM: dts: keystone: Add generic compatible string for I2C EEPROM

Keerthy (1):
      ARM: dts: keystone-k2l: Add the second gpio bank node

Nishanth Menon (8):
      ARM: dts: keystone*: Standardize license with SPDX tag
      ARM: dts: keystone*: Use a single soc0 instance
      ARM: dts: keystone: Get rid of usage of skeleton.dtsi
      ARM: dts: keystone: Add missing unit name to interrupt controller
      ARM: dts: keystone-clocks: Add missing unit name to clock nodes that have regs
      ARM: dts: keystone-hk-clocks: Add missing unit name to clock nodes that have regs
      ARM: dts: keystone-k2e-clocks: Add missing unit name to clock nodes that have regs
      ARM: dts: keystone-k2l-clocks: Add missing unit name to clock nodes that have regs

Vignesh R (5):
      ARM: dts: keystone-k2g: Add QSPI DT entry
      ARM: dts: keystone-k2g-evm: Fix botched up merge
      ARM: dts: keystone-k2g: Move ti,non-removable property to board dts
      ARM: dts: keystone-k2g-evm: Add QSPI DT node.
      ARM: dts: keystone-k2g-ice: Add DT nodes for few peripherals

 arch/arm/boot/dts/keystone-clocks.dtsi      |  59 +++--
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi  |  15 +-
 arch/arm/boot/dts/keystone-k2e-evm.dts      |  13 +-
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi   |   7 +-
 arch/arm/boot/dts/keystone-k2e.dtsi         |  11 +-
 arch/arm/boot/dts/keystone-k2g-evm.dts      | 115 +++++++---
 arch/arm/boot/dts/keystone-k2g-ice.dts      | 339 +++++++++++++++++++++++++++-
 arch/arm/boot/dts/keystone-k2g.dtsi         |  58 +++--
 arch/arm/boot/dts/keystone-k2hk-clocks.dtsi |  81 ++++---
 arch/arm/boot/dts/keystone-k2hk-evm.dts     |  59 +++--
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi  |   7 +-
 arch/arm/boot/dts/keystone-k2hk.dtsi        |  11 +-
 arch/arm/boot/dts/keystone-k2l-clocks.dtsi  |  51 ++---
 arch/arm/boot/dts/keystone-k2l-evm.dts      |  13 +-
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi   |   7 +-
 arch/arm/boot/dts/keystone-k2l.dtsi         |  55 ++++-
 arch/arm/boot/dts/keystone.dtsi             |  18 +-
 17 files changed, 676 insertions(+), 243 deletions(-)
