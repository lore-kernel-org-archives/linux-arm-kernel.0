From: fisaksen@baylibre.com (Frode Isaksen)
Date: Thu, 23 Feb 2017 19:01:55 +0100
Subject: [PATCH v3 0/6] Enable DMA for daVinci SPI controller 
Message-ID: <1487872921-26628-1-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA for the daVinci SPI using the SPI framework DMA mapping
function. 
Add fixes caused by large number of SG entries.
Do not allow vmalloc'ed buffers for DMA.
Also, add some extra options to the spi-loopback-test
module to catch errors caused by many SG entries
and VIVT cache.
This has been tested using spidev_test, spi-loopback-test and
mounting and read/write UBIFS volume over SPI flash.

v2 changes:
- Use SPI_MASTER_MUST_ flag(s) for dummy buffer allocation (thanks
Mark Brown).
- For rx-only transfers, use rx buffer as dummy tx buffer to avoid
errors with more than 20 SG entries.
- Improved comments and use #define for contants.
- Abandon patches to set loopback and limit transfer size in
spi-loopback-test.

v3 changes:
- Disable DMA for vmalloc'ed buffers.
- Reworked 'can_dma' function.
- Add option to skip a check in spi-loopback-test to catch VIVT
cache errors.

Thanks,
Frode
