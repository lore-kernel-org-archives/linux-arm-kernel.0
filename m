From: fisaksen@baylibre.com (Frode Isaksen)
Date: Fri, 17 Feb 2017 11:38:18 +0100
Subject: [PATCH v2 0/6] Enable DMA for daVinci SPI controller 
Message-ID: <1487327904-28311-1-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA for the daVinci SPI using the SPI framework DMA mapping
function. Add fixes caused by large numer of SG entries
and VIVT cache.
Also, add some extra options to the spi-loopback-test
module to catch errors caused by many SG entries.
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

Thanks,
Frode
