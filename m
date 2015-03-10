From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:46 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC DT Updates for v4.1
Message-ID: <cover.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these second round of Renesas ARM based SoC DT updates
for v4.1.

This pull request is based on the previous round of
such requests, tagged as renesas-dt-for-v4.1,
which you have already pulled.


The following changes since commit b8e8ea127d00f1b0c18d8c1ae1b8388e190d5052:

  ARM: shmobile: r8a7794: add SDHI DT support (2015-02-24 08:18:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v4.1

for you to fetch changes up to 90ca409a1e6b9b72d1b6ae716cd7a63335fd0e87:

  ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up source (2015-03-07 10:07:30 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC DT Updates for v4.1

* ape6evm board
  - Configure GPIO keys as wake-up source
  - Enable pull-up for GPIO switches
  - Correct polarity of LEDs
* r8a7791 SoC
  - Correct IPMMU-GP clock to device tree
* r8a7794 SoC
  - Correct ethernet controller PHY IRQ
* lager, koelsch and marzen boards
  - Add DU external pixel clock to DT
* lager board
  - Add HDMI output support to DT
* r8a7791 and r8a7790 SoCs
  - Tidy up SDHI register size in DT
  - Reference DMA channels for SDHI in DT

----------------------------------------------------------------
Geert Uytterhoeven (3):
      ARM: shmobile: ape6evm dts: Fix polarity of LEDs
      ARM: shmobile: ape6evm dts: Enable pull-up for GPIO switches
      ARM: shmobile: ape6evm dts: Configure the custom switch as wake-up source

Kazuya Mizuguchi (2):
      ARM: shmobile: r8a7790: Fix HSUSB clock to hp_clk from mp_clk
      ARM: shmobile: r8a7791: Fix HSUSB clock to hp_clk from mp_clk

Kuninori Morimoto (2):
      ARM: shmobile: r8a7790: tidyup SDHI register size on DTSI
      ARM: shmobile: r8a7791: tidyup SDHI register size on DTSI

Laurent Pinchart (7):
      ARM: shmobile: r8a7790: Reference DMA channels in SDHI DT nodes
      ARM: shmobile: r8a7791: Reference DMA channels in SDHI DT nodes
      ARM: shmobile: lager: Add DU HDMI output support
      ARM: shmobile: marzen: Add DU external pixel clock to DT
      ARM: shmobile: koelsch: Add DU external pixel clocks to DT
      ARM: shmobile: lager: Add DU external pixel clocks to DT
      ARM: shmobile: r8a7794: alt: Fix ethernet controller PHY IRQ line

Ryo Kataoka (1):
      ARM: shmobile: r8a7791: Fix IPMMU-GP clock to device tree

 arch/arm/boot/dts/r8a73a4-ape6evm.dts | 22 ++++++++---
 arch/arm/boot/dts/r8a7779-marzen.dts  |  9 +++++
 arch/arm/boot/dts/r8a7790-lager.dts   | 69 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/r8a7790.dtsi        | 15 ++++++--
 arch/arm/boot/dts/r8a7791-koelsch.dts | 19 ++++++++++
 arch/arm/boot/dts/r8a7791.dtsi        | 14 +++++--
 arch/arm/boot/dts/r8a7794-alt.dts     |  2 +-
 7 files changed, 136 insertions(+), 14 deletions(-)
