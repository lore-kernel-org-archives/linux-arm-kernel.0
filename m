From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Tue, 15 Mar 2016 13:41:37 +0100
Subject: [PATCHv2 00/31] ARM: dts: r8a779[0-4]: Reference both DMA controllers
Message-ID: <1458045728-4758-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

R-Car Gen2 have two DMA controllers, which are equivalent. However DMA
slaves were tied only to a single DMA controller in .dtsi. This series
add references to to both DMA controllers for all nodes that previously
only referenced one of them. It also adds dma references to the SDHI
nodes for r8a7794 which according to the datasheet should work but I
have not access to HW to verify.

Tested on Koelsch (r8a7791) by altering the compatible value of either
dmac0 or dmac1 and verifying that the DMA slaves pick the DMA controller
that is instantiated.

For your convince the series can be fetched from
https://git.ragnatech.se/linux rcar-dmas-dt-2

* Changes since v1
- Rebase on top of renesas-devel-20160315-v4.5 and add dmas references
  new nodes (r8a7790: scif2 r8a7793: i2c6,i2c7,i2c8).
- Correct error in commit message 31/31 (s/QSPI/MMCIF).
- Collect Ack and Reviewed tags from Geert.

Niklas S?derlund (31):
  ARM: dts: r8a7790: Reference both DMA controllers in SCIFA nodes
  ARM: dts: r8a7790: Reference both DMA controllers in SCIFB nodes
  ARM: dts: r8a7790: Reference both DMA controllers in HSCIF nodes
  ARM: dts: r8a7790: Reference both DMA controllers in SCIF nodes
  ARM: dts: r8a7790: Reference both DMA controllers in MSIOF nodes
  ARM: dts: r8a7790: Reference both DMA controllers in QSPI node
  ARM: dts: r8a7790: Reference both DMA controllers in IIC nodes
  ARM: dts: r8a7790: Reference both DMA controllers in SDHI nodes
  ARM: dts: r8a7790: Reference both DMA controllers in MMCIF nodes
  ARM: dts: r8a7791: Reference both DMA controllers in SCIFA nodes
  ARM: dts: r8a7791: Reference both DMA controllers in SCIFB nodes
  ARM: dts: r8a7791: Reference both DMA controllers in HSCIF nodes
  ARM: dts: r8a7791: Reference both DMA controllers in SCIF nodes
  ARM: dts: r8a7791: Reference both DMA controllers in MSIOF nodes
  ARM: dts: r8a7791: Reference both DMA controllers in QSPI node
  ARM: dts: r8a7791: Reference both DMA controllers in IIC nodes
  ARM: dts: r8a7791: Reference both DMA controllers in SDHI nodes
  ARM: dts: r8a7791: Reference both DMA controllers in MMCIF node
  ARM: dts: r8a7793: Reference both DMA controllers in SCIFA nodes
  ARM: dts: r8a7793: Reference both DMA controllers in SCIFB nodes
  ARM: dts: r8a7793: Reference both DMA controllers in HSCIF nodes
  ARM: dts: r8a7793: Reference both DMA controllers in SCIF nodes
  ARM: dts: r8a7793: Reference both DMA controllers in QSPI node
  ARM: dts: r8a7793: Reference both DMA controllers in IIC nodes
  ARM: dts: r8a7794: Reference both DMA controllers in SCIFA nodes
  ARM: dts: r8a7794: Reference both DMA controllers in SCIFB nodes
  ARM: dts: r8a7794: Reference both DMA controllers in HSCIF nodes
  ARM: dts: r8a7794: Reference both DMA controllers in SCIF nodes
  ARM: dts: r8a7794: Reference both DMA controllers in QSPI node
  ARM: dts: r8a7794: Reference both DMA controllers in SDHI nodes
  ARM: dts: r8a7794: Reference both DMA controllers in MMCIF node

 arch/arm/boot/dts/r8a7790.dtsi | 130 +++++++++++++++++++++---------------
 arch/arm/boot/dts/r8a7791.dtsi | 145 ++++++++++++++++++++++++-----------------
 arch/arm/boot/dts/r8a7793.dtsi | 110 ++++++++++++++++++-------------
 arch/arm/boot/dts/r8a7794.dtsi | 109 +++++++++++++++++++------------
 4 files changed, 300 insertions(+), 194 deletions(-)

--
2.7.2
