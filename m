From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Mon,  5 Mar 2018 16:41:12 -0800
Subject: [GIT PULL 1/2] ARM: Keystone DTS for v4.17
Message-ID: <1520296873-12982-1-git-send-email-santosh.shilimkar@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 91ab883eb21325ad80f3473633f794c78ac87f51:

  Linux 4.16-rc2 (2018-02-18 17:29:42 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.17

for you to fetch changes up to 07f3398d38da44e1c3741280791c2b62dc9ac785:

  ARM: dts: keystone-k2g: Fix unit-address formatting for serial nodes (2018-03-05 16:18:49 -0800)

----------------------------------------------------------------
ARM: Keystone DTS for 4.17

 - Andrew's various DTS warning fixes
 - clock address separator fix
 - EDAC support for EMIF
 - serial dts node unit address format fix

----------------------------------------------------------------
Andrew F. Davis (8):
      ARM: dts: keystone: Move keystone_irq to under device-state-control
      ARM: dts: keystone: Move reset-controller to under device-state-control
      ARM: dts: keystone-k2e: Move keystone_dsp_gpio to under device-state-control
      ARM: dts: keystone-k2l: Move keystone_dsp_gpio to under device-state-control
      ARM: dts: keystone-k2hk: Move keystone_dsp_gpio to under device-state-control
      ARM: dts: keystone-k2g: Move keystone_irq to under device-state-control
      ARM: dts: keystone-k2g: Move keystone_dsp_gpio to under device-state-control
      ARM: dts: keystone-k2g: Move usb-phy nodes out of soc0

Suman Anna (2):
      ARM: dts: keystone-k2e-clocks: Fix missing unit address separator
      ARM: dts: keystone-k2g: Fix unit-address formatting for serial nodes

Tero Kristo (1):
      dt-bindings: memory: ti-emif: add edac support under emif

 .../bindings/memory-controllers/ti/emif.txt        |  13 ++-
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi         |   2 +-
 arch/arm/boot/dts/keystone-k2e.dtsi                |  13 ++-
 arch/arm/boot/dts/keystone-k2g.dtsi                |  69 ++++++++------
 arch/arm/boot/dts/keystone-k2hk.dtsi               | 104 +++++++++++----------
 arch/arm/boot/dts/keystone-k2l.dtsi                |  52 ++++++-----
 arch/arm/boot/dts/keystone.dtsi                    |  35 ++++---
 7 files changed, 168 insertions(+), 120 deletions(-)
