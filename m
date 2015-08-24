From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 24 Aug 2015 11:45:14 +0800
Subject: [PATCHi v3 0/4] Fixup mediatek spi driver 
Message-ID: <1440387918-22191-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilk Liu <leilk.liu@mediatek.com>

This series are based on 4.2-rc1 and provide four patches to fix mediatek spi driver.

Change in v3:
1. The follow patches are applied, so remove them from series:
  - spi: mediatek: fix spi incorrect endian usage
  - spi: medaitek: revise quirks compatibility style
  - spi: mediatek: use BIT() to instead of SPI_CMD_*_OFFSET
2. The patch "spi: mediatek: revise coding style" title is not clear, so split it to four patches.

Change in v2:
1. The patch "spi: mediatek: remove redundant clock in prepare_hardware/unprepare_hardware" 
   is applied, so remove it from series.
2. fix incorrect endian usage to support little-endian and big-endian system.
3. revise quirks style to bool.
4. use BIT() to instead of SPI_CMD_*_OFFSET.
5. revise coding style, such as time name, and variable type. 

Leilk Liu (4):
  spi: mediatek: add linux/io.h include file
  spi: mediatek: replace int with u32, delete TAB and define
    MTK_SPI_PAUSE_INT_STATUS marco
  spi: mediatek: add PM clk_prepare_enable fail flow
  spi: mediatek: replace *_time name

 drivers/spi/spi-mt65xx.c | 52 ++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 22 deletions(-)

--
1.8.1.1.dirty
