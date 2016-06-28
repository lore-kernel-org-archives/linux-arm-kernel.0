From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 28 Jun 2016 20:46:19 +0800
Subject: [GIT PULL 4/5] Freescale arm64 device tree updates for 4.8
In-Reply-To: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
References: <1467117980-20063-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1467117980-20063-4-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1a695a905c18548062509178b98bc91e67510864:

  Linux 4.7-rc1 (2016-05-29 09:29:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-dt64-4.8

for you to fetch changes up to 2983e625bf2af422a6f55febb784fe34df834322:

  arm64: dts: ls2080a: Add cache nodes for cacheinfo support (2016-06-21 14:33:34 +0800)

----------------------------------------------------------------
The Freescale arm64 device tree updates for 4.8:
 - Update address-cells and reg properties of cpu nodes, considering
   MPIDR_EL1[63:32] bits are not used for CPUs identification on ls1043a
   and ls2080a
 - Adds the cache nodes and next-level-cache property for ls1043a and
   ls2080a to get cacheinfo work on these platforms
 - Add dma-coherent for ls1043a PCI nodes to utilize the hardware
   capability on data coherency
 - Add dis_rxdet_inp3_quirk property for USB3 device to disable rx
   detection in P3 PHY mode

----------------------------------------------------------------
Alison Wang (1):
      arm64: dts: fsl: Update address-cells and reg properties of cpu nodes

Li Yang (2):
      arm64: dts: ls1043a: Add cache nodes for cacheinfo support
      arm64: dts: ls2080a: Add cache nodes for cacheinfo support

Liu Gang (2):
      bindings: PCI: layerscape: Add 'dma-coherent' property
      arm64: dts: ls1043a: Add 'dma-coherent' for ls1043a PCI nodes

Rajesh Bhagat (2):
      arm64: dts: ls2080a: Add dis_rxdet_inp3_quirk property to USB3 node
      arm64: dts: ls1043a: Add dis_rxdet_inp3_quirk property to USB3 node

 .../devicetree/bindings/pci/layerscape-pci.txt     |  4 ++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi     | 24 +++++++++---
 arch/arm64/boot/dts/freescale/fsl-ls2080a.dtsi     | 44 +++++++++++++++++-----
 3 files changed, 58 insertions(+), 14 deletions(-)
