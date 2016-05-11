From: niklas.soderlund+renesas@ragnatech.se (=?UTF-8?q?Niklas=20S=C3=B6derlund?=)
Date: Wed, 11 May 2016 15:13:54 +0200
Subject: [PATCHv3 0/4] ARM: dts: r8a779[0-4]: Reference both DMA controllers
Message-ID: <1462972438-20797-1-git-send-email-niklas.soderlund+renesas@ragnatech.se>
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
that is available.

* Changes since v2
- Squash a rather large series to one patch per SoC
- Rebase on top of renesas-devel-20160509-v4.6-rc7
- Always reference dmac0 before dmac1

* Changes since v1
- Rebase on top of renesas-devel-20160315-v4.5 and add dmas references
  new nodes (r8a7790: scif2 r8a7793: i2c6,i2c7,i2c8).
- Correct error in commit message 31/31 (s/QSPI/MMCIF).
- Collect Ack and Reviewed tags from Geert.


Niklas S?derlund (4):
  ARM: dts: r8a7790: Reference both DMA controllers
  ARM: dts: r8a7791: Reference both DMA controllers
  ARM: dts: r8a7793: Reference both DMA controllers
  ARM: dts: r8a7794: Reference both DMA controllers

 arch/arm/boot/dts/r8a7790.dtsi | 131 ++++++++++++++++++++++---------------
 arch/arm/boot/dts/r8a7791.dtsi | 145 ++++++++++++++++++++++++-----------------
 arch/arm/boot/dts/r8a7793.dtsi | 130 +++++++++++++++++++++---------------
 arch/arm/boot/dts/r8a7794.dtsi | 119 ++++++++++++++++++++-------------
 4 files changed, 318 insertions(+), 207 deletions(-)

--
2.8.2
