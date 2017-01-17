From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jan 2017 21:09:47 +0100
Subject: [GIT PULL] ARM: at91: DT for 4.11
Message-ID: <20170117200947.lkx2gz6e2fxbhv5f@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here is the DT pull request, adding a few boards and improving
sama5d2 and sama5d4 support.

The following changes since commit 7ce7d89f48834cefece7804d38fc5d85382edf77:

  Linux 4.10-rc1 (2016-12-25 16:13:08 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.11-dt

for you to fetch changes up to 21dd0ece34c2a07432a1cd0bbcb4815ce2b49173:

  ARM: dts: at91: add devicetree for the Axentia TSE-850 (2017-01-10 16:16:33 +0100)

----------------------------------------------------------------
DT for 4.11:

 - New boards: Axentia TSE-850, sama5d36ek CMP
 - new device definitions for sama5d2
 - Fix DMA allocation on sama5d4 for secure peripherals

----------------------------------------------------------------
Alex (1):
      ARM: dts: at91: sama5d2: add ssc0 definition

Nicolas Ferre (5):
      ARM: dts: at91: sama5d4: change DMA allocation for secure peripherals
      ARM: dts: at91: sama5d4 Xplained: enable UART1 node with DMA
      ARM: dts: at91: add dma1 definition to sama5d2
      ARM: dts: at91: sama5d2: move UART3 to DMA1
      ARM: dts: at91: sama5d2 Xplained: use DMA for UART3

Peter Rosin (2):
      ARM: dts: at91: sama5d3_uart: fix reg sizes to match documentation
      ARM: dts: at91: add devicetree for the Axentia TSE-850

Wenyou Yang (1):
      ARM: dts: at91: add dts file for sama5d36ek CMP board

 Documentation/devicetree/bindings/arm/axentia.txt |  19 ++
 MAINTAINERS                                       |   8 +
 arch/arm/boot/dts/Makefile                        |   2 +
 arch/arm/boot/dts/at91-linea.dtsi                 |  49 ++++
 arch/arm/boot/dts/at91-sama5d2_xplained.dts       |   2 +
 arch/arm/boot/dts/at91-sama5d4_xplained.dts       |   6 +
 arch/arm/boot/dts/at91-tse850-3.dts               | 274 ++++++++++++++++++++
 arch/arm/boot/dts/sama5d2.dtsi                    |  30 ++-
 arch/arm/boot/dts/sama5d36ek_cmp.dts              |  87 +++++++
 arch/arm/boot/dts/sama5d3_uart.dtsi               |   4 +-
 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi             | 201 +++++++++++++++
 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi             | 301 ++++++++++++++++++++++
 arch/arm/boot/dts/sama5d4.dtsi                    |  16 +-
 13 files changed, 987 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/axentia.txt
 create mode 100644 arch/arm/boot/dts/at91-linea.dtsi
 create mode 100644 arch/arm/boot/dts/at91-tse850-3.dts
 create mode 100644 arch/arm/boot/dts/sama5d36ek_cmp.dts
 create mode 100644 arch/arm/boot/dts/sama5d3xcm_cmp.dtsi
 create mode 100644 arch/arm/boot/dts/sama5d3xmb_cmp.dtsi

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
