From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Fri, 1 Aug 2014 19:40:31 +0300
Subject: [PATCH v2 0/2] spi: davinci: add support for gpio cs through dt
Message-ID: <1406911233-18999-1-git-send-email-grygorii.strashko@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series enables GPIO chip select feature for Davinci SPI
when DT-boot mode is used.
This is actual for Keystone 2 which supports DT-boot mode only.

Changes in v2:
- gpio_request_one() is used
- as suggested by Mark Brown, new patch has been added which updates
  Davinci SPI driver to use cs_gpio field
  of SPI device structure (spi_device) for both DT and non-DT cases.

v1:
 http://www.spinics.net/lists/linux-spi/msg01446.html

Grygorii Strashko (1):
  spi: davinci: use spi_device.cs_gpio to store gpio cs per spi device

Murali Karicheri (1):
  spi: davinci: add support to configure gpio cs through dt

 .../devicetree/bindings/spi/spi-davinci.txt        |    9 ++-
 drivers/spi/spi-davinci.c                          |   60 ++++++++++++++------
 2 files changed, 52 insertions(+), 17 deletions(-)

-- 
1.7.9.5
