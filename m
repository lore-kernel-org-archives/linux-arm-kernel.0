From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Tue, 16 Apr 2013 15:03:04 +0200
Subject: [PATCH v2 0/6] ARM: at91: move to generic DMA device tree binding
Message-ID: <1366117390-24686-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Hi,

This set of patches introduces DMA device tree bindings support for the atmel
DMA controller and first driver conversions.

Patch 3/6 has already been taken by Wolfram.

v2 changes:
- update documentation about dma bindings according to Nicolas' comments
- put dtsi changes in a separate patch
- add dtb update for i2c and mci nodes

Ludovic Desroches (6):
  at_hdmac: move to generic DMA binding
  ARM: at91: dts: set #dma-cells to the correct value
  i2c: at91: convert to dma_request_slave_channel_compat()
  ARM: at91: dts: add i2c dma support
  mci: at91: convert to dma_request_slave_channel_compat()
  ARM: at91: dts: add MCI DMA support

 .../devicetree/bindings/dma/atmel-dma.txt          | 35 ++++++--
 arch/arm/boot/dts/at91sam9g45.dtsi                 |  5 ++
 arch/arm/boot/dts/at91sam9n12.dtsi                 |  9 +++
 arch/arm/boot/dts/at91sam9x5.dtsi                  | 15 ++++
 arch/arm/boot/dts/sama5d3.dtsi                     | 19 ++++-
 drivers/dma/at_hdmac.c                             | 93 ++++++++++++++++++++--
 drivers/dma/at_hdmac_regs.h                        |  4 +
 drivers/i2c/busses/i2c-at91.c                      | 49 ++++++------
 drivers/mmc/host/atmel-mci.c                       | 25 +++---
 9 files changed, 204 insertions(+), 50 deletions(-)

-- 
1.7.11.3
