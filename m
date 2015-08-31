From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 31 Aug 2015 21:18:55 +0800
Subject: [PATCH 0/3] Fix Mediatek SPI bus driver clock usage error
Message-ID: <1441027138-16458-1-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Leilk Liu <leilk.liu@mediatek.com>

This series are based on 4.2-rc1 and provide three patches
to fix mediatek spi driver clock usage error.

spi clock manages flow:
  CLK_TOP_SYSPLL3_D2 ---> CLK_TOP_SPI_SEL ---> CLK_PERI_SPI0
    (source clock)           (clock mux)       (clock gate)
spi driver should choose source clock by clock mux, then enable clock gate.

Leilk Liu (3):
  spi: mediatek: remove clk_disable_unprepare()
  spi: mediatek: fix spi clock usage error
  spi: Mediatek: Document devicetree bindings update for spi bus

 .../devicetree/bindings/spi/spi-mt65xx.txt         | 16 +++++++++------
 drivers/spi/spi-mt65xx.c                           | 24 ++++++++++++++--------
 2 files changed, 25 insertions(+), 15 deletions(-)

--
1.8.1.1.dirty
