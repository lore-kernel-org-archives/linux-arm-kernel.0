From: andi.shyti@samsung.com (Andi Shyti)
Date: Fri, 08 Jul 2016 21:18:20 +0900
Subject: [PATCH 0/4] spi s3c64xx ioclk handling
Message-ID: <1467980304-14093-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset improves the compatibility between the s3c64xx
driver and the exynos5433. One point of incompatibility, indeed,
was that the SPI controller in exynos5433 is fed by three clocks
which need to be handled by the driver. The third clock is the
ioclk which support is the main purpose of this patchset.

The last patch is a bit unrelated, it restores a comment that has
been removed earlier by mistake.

Thanks,
Andi

Andi Shyti (4):
  spi: s3c64xx: rename goto labels to meaningful names
  bindings: spi-samsung: add exynos5433 spi compatible
  spi: s3c64xx: add nexynos5433 compatible for ioclk handling
  spi: s3c64xx: restore removed comments

 .../devicetree/bindings/spi/spi-samsung.txt        |  1 +
 drivers/spi/spi-s3c64xx.c                          | 83 +++++++++++++++++-----
 2 files changed, 67 insertions(+), 17 deletions(-)

-- 
2.8.1
