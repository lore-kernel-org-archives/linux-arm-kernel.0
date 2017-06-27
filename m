From: amelie.delaunay@st.com (Amelie Delaunay)
Date: Tue, 27 Jun 2017 17:45:12 +0200
Subject: [PATCHv2 0/9] STM32 SPI various fixes
Message-ID: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset answers to the reviews done after STM32 SPI driver introduction.

Amelie Delaunay (9):
  dt-bindings: spi: stm32: use SoC specific compatible
  spi: stm32: fix compatible to fit with new bindings
  dt-bindings: spi: stm32: fix example with st,spi-midi-ns property
  spi: stm32: replace st,spi-midi with st,spi-midi-ns to fit bindings
  spi: stm32: use normal conditional statements instead of ternary
    operator
  spi: stm32: add runtime PM support
  spi: stm32: enhance DMA error management
  spi: stm32: fix potential dereference null return value
  spi: spidev: add Aardvark to device tree compatibility list

 .../devicetree/bindings/spi/spi-stm32.txt          |  11 +-
 drivers/spi/spi-stm32.c                            | 130 +++++++++++++++------
 drivers/spi/spidev.c                               |   1 +
 3 files changed, 99 insertions(+), 43 deletions(-)

-- 
1.9.1
