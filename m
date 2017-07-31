From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 31 Jul 2017 17:03:38 +0200
Subject: [GIT PULL] Renesas ARM Based SoC Defconfig Updates for v4.14
Message-ID: <cover.1501511664.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC defconfig updates for v4.14.


The following changes since commit 5771a8c08880cdca3bfb4a3fc6d309d6bba20877:

  Linux v4.13-rc1 (2017-07-15 15:22:10 -0700)

are available in the git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-defconfig-for-v4.14

for you to fetch changes up to 52078ca712cd933844721aaa700b3bd85234841f:

  ARM: multi_v7_defconfig: Enable DMA for Renesas serial ports (2017-07-27 16:06:23 +0200)

----------------------------------------------------------------
Renesas ARM Based SoC Defconfig Updates for v4.14

* Enable DMA for Renesas serial ports

  Geert Uytterhoeven says, "DMA for (H)SCIF(A|B) serial ports on Renesas
  R-Car Gen2 and RZ/G1 SoCs is considered stable, hence enable it by
  default.".

* Enable Ethernet AVB

  For the iWave RZ/G1M Q7 SOM

* Replace DRM_RCAR_HDMI by generic bridge options
* Replace SND_SOC_RSRC_CARD by SND_SIMPLE_SCU_CARD
* Replace USB_XHCI_RCAR by USB_XHCI_PLATFORM
* Enable missing PCIE_RCAR dependency

  Defconfig updates for various Kconfig updates covering
  renamed Kconfig symbols, now missing dependancies and so on.

----------------------------------------------------------------
Biju Das (1):
      ARM: shmobile: defconfig: Enable Ethernet AVB

Geert Uytterhoeven (9):
      ARM: shmobile: defconfig: Enable missing PCIE_RCAR dependency
      ARM: shmobile: defconfig: Replace USB_XHCI_RCAR by USB_XHCI_PLATFORM
      ARM: shmobile: defconfig: Replace SND_SOC_RSRC_CARD by SND_SIMPLE_SCU_CARD
      ARM: shmobile: defconfig: Replace DRM_RCAR_HDMI by generic bridge options
      ARM: shmobile: defconfig: Enable DMA for serial ports
      ARM: shmobile: defconfig: Refresh
      ARM: multi_v7_defconfig: Replace SND_SOC_RSRC_CARD by SND_SIMPLE_SCU_CARD
      ARM: multi_v7_defconfig: Replace DRM_RCAR_HDMI by generic bridge options
      ARM: multi_v7_defconfig: Enable DMA for Renesas serial ports

 arch/arm/configs/multi_v7_defconfig |  5 +++--
 arch/arm/configs/shmobile_defconfig | 17 ++++++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)
