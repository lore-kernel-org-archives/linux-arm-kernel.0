From: ssantosh@kernel.org (Santosh Shilimkar)
Date: Wed, 16 Aug 2017 17:30:40 -0700
Subject: [GIT PULL 1/3] ARM: Keystone DTS for 4.14
Message-ID: <1502929842-8156-1-git-send-email-ssantosh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone_dts_for_4.14

for you to fetch changes up to 6794d3771c319bd67f95575f11846a0fe86105c5:

  ARM: dts: keystone-k2g-ice: Add and enable DSP CMA memory pool (2017-08-12 10:58:11 -0700)

----------------------------------------------------------------
ARM: Keystone DTS for 4.14

Contents:
- ti-sci power domain, clock and reset controller support
- DSP nodes for k2h/k2l/k2e evms
- DSP CMA memory pools for k2h/k2l/k2e/keg evms
- MMC/hsmmc suport for k2g
- eDMA support for k2g
- DCAN support for k2g

----------------------------------------------------------------
Andrew F. Davis (2):
      ARM: dts: keystone-k2g: Add TI SCI reset-controller node
      ARM: dts: keystone-k2g-evm: Add and enable DSP CMA memory pool

Dave Gerlach (2):
      dt-bindings: Drop k2g genpd device ID macros
      ARM: dts: keystone-k2g: Add ti-sci power domain node

Franklin S Cooper Jr (1):
      dt-bindings: net: c_can: Update binding for clock and power-domains property

Keerthy (1):
      ARM: dts: keystone-k2g: Add gpio nodes

Lokesh Vutla (5):
      dt-bindings: ti,edma: Add 66AK2G specific information
      dt-bindings: ti,omap-hsmmc: Add 66AK2G mmc controller
      ARM: dts: keystone-k2g: add MMC0 and MMC1 nodes
      ARM: dts: keystone-k2g-evm: Enable MMC0 and MMC1
      ARM: dts: k2g: Add DCAN nodes

Nishanth Menon (1):
      ARM: dts: keystone-k2g: Add PMMC node to support TI-SCI protocol

Peter Ujfalusi (1):
      ARM: dts: keystone-k2g: Add eDMA nodes

Sam Nelson (3):
      ARM: dts: keystone-k2hk-evm: Add and enable common DSP CMA memory pool
      ARM: dts: keystone-k2l-evm: Add and enable common DSP CMA memory pool
      ARM: dts: keystone-k2e-evm: Add and enable DSP CMA memory pool

Suman Anna (5):
      ARM: dts: keystone-k2hk: Add DSP nodes
      ARM: dts: keystone-k2l: Add DSP nodes
      ARM: dts: keystone-k2e: Add DSP node
      ARM: dts: keystone-k2g: Add DSP node
      ARM: dts: keystone-k2g-ice: Add and enable DSP CMA memory pool

Tero Kristo (1):
      ARM: dts: keystone-k2g: Add ti-sci clock provider node

 Documentation/devicetree/bindings/dma/ti-edma.txt  |  95 +++++++++-
 .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |  52 ++++--
 .../devicetree/bindings/net/can/c_can.txt          |  13 +-
 .../devicetree/bindings/soc/ti/sci-pm-domain.txt   |   5 +-
 arch/arm/boot/dts/keystone-k2e-evm.dts             |  18 ++
 arch/arm/boot/dts/keystone-k2e.dtsi                |  20 ++
 arch/arm/boot/dts/keystone-k2g-evm.dts             |  71 +++++++
 arch/arm/boot/dts/keystone-k2g-ice.dts             |  18 ++
 arch/arm/boot/dts/keystone-k2g.dtsi                | 204 +++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2hk-evm.dts            |  53 ++++++
 arch/arm/boot/dts/keystone-k2hk.dtsi               | 139 ++++++++++++++
 arch/arm/boot/dts/keystone-k2l-evm.dts             |  33 ++++
 arch/arm/boot/dts/keystone-k2l.dtsi                |  71 +++++++
 include/dt-bindings/genpd/k2g.h                    |  90 ---------
 14 files changed, 769 insertions(+), 113 deletions(-)
 delete mode 100644 include/dt-bindings/genpd/k2g.h
