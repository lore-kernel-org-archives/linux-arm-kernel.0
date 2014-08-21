From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Thu, 21 Aug 2014 18:25:04 +0300
Subject: [PATCH 0/2] spi: davinci: fixes and updates
Message-ID: <1408634706-5762-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The first patch fixes the issue for the case when SPI_NO_CS flag is set
which was introduced by previous
commit a88e34ea213e1b ("spi: davinci: add support to configure gpio cs through dt"). 

The second patch completes migration of Davinci SPI driver to DT
and adds ability to configure additional properties for SPI slave
devices which were possible to configure only from platform code
through struct davinci_spi_config

Grygorii Strashko (2):
  spi: davinci: fix SPI_NO_CS functionality
  spi: davinci: support adding delay between transmission

 .../devicetree/bindings/spi/spi-davinci.txt        |   18 ++++
 drivers/spi/spi-davinci.c                          |   96 +++++++++++++++++---
 2 files changed, 99 insertions(+), 15 deletions(-)

-- 
1.7.9.5
