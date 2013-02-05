From: girishks2000@gmail.com (Girish K S)
Date: Tue,  5 Feb 2013 15:09:40 -0800
Subject: [PATCH 0/4] Add polling support for 64xx spi controller
Message-ID: <1360105784-12282-1-git-send-email-ks.giri@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[PATCH 1/4]: fixes the error handling in the interrupt handler
[PATCH 2/4]: The existing driver support partial polling mode.
	     This patch modifies the current driver to support
	     only polling mode.
[PATCH 3/4]: Adds quirk to support SoC's with dedicated i/o pins
[PATCH 4/4]: Adds the support for exynos5440 SoC, this SoC has
	     no support for dma transfer and consists of dedicated
	     i/o pins.

Girish K S (4):
  spi: s3c64xx: modified error interrupt handling and init
  spi: s3c64xx: added support for polling mode
  spi: s3c64xx: add gpio quirk for controller
  spi: s3c64xx: add support for exynos5440 spi

 drivers/spi/spi-s3c64xx.c |  157 ++++++++++++++++++++++++++++-----------------
 1 file changed, 98 insertions(+), 59 deletions(-)

-- 
1.7.10.4
