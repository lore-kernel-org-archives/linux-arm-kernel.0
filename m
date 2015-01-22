From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 22 Jan 2015 01:40:45 +0100
Subject: [Request pull] mvebu/soc #2
Message-ID: <20150122004045.GB9533@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof

Here is the second incremental pull request for mvebu/soc.

Note these depend on mvebu-fixes-3.19-4, which in turn depends on
v3.19-rc4.

	Andrew


The following changes since commit eaa27f34e91a14cdceed26ed6c6793ec1d186115:

  linux 3.19-rc4 (2015-01-11 12:44:53 -0800)

are available in the git repository at:

  git://git.infradead.org/linux-mvebu.git tags/mvebu-soc-3.20-2

for you to fetch changes up to 1737cac6936938a9bc52c03c4a3ff2032c702fa5:

  bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window (2015-01-19 16:09:16 -0600)

----------------------------------------------------------------
Soc patches for mvebu for v3.20, part #2.

Note these depend on mvebu-fixes-3.19-4, which in turn depends on
v3.19-rc4.

bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window
bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x
ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware I/O coherency
bus: mvebu-mbus: use automatic I/O synchronization barriers

----------------------------------------------------------------
Andrew Lunn (2):
      bus: mvebu-mbus: fix support of MBus window 13
      Merge branch 'mvebu/fixes-3' into mvebu/soc

Gregory CLEMENT (1):
      ARM: mvebu: Update the SoC ID and revision definitions

Maxime Ripard (2):
      ARM: mvebu: Rename DEBUG_LL to indicate UART index
      ARM: mvebu: Add UART1 as DEBUG_LL possible target

Michal Mazur (1):
      bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x

Thomas Petazzoni (4):
      ARM: mvebu: completely disable hardware I/O coherency
      bus: mvebu-mbus: use automatic I/O synchronization barriers
      ARM: mvebu: use arm_coherent_dma_ops and re-enable hardware I/O coherency
      bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus bridge window

 arch/arm/Kconfig.debug             |  35 +++--
 arch/arm/mach-mvebu/coherency.c    |  51 +------
 arch/arm/mach-mvebu/mvebu-soc-id.h |  18 +++
 drivers/bus/mvebu-mbus.c           | 277 +++++++++++++++++++++++++++++--------
 4 files changed, 267 insertions(+), 114 deletions(-)
