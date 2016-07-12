From: andi.shyti@samsung.com (Andi Shyti)
Date: Tue, 12 Jul 2016 19:02:09 +0900
Subject: [PATCH v3 0/7] spi s3c64xx ioclk handling
Message-ID: <1468317736-18841-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this patchset improves the compatibility between the s3c64xx
driver and the exynos5433. One point of incompatibility, indeed,
was that the SPI controller in exynos5433 is fed by three clocks
which need to be handled by the driver. The third clock is the
ioclk which support is the main purpose of this patchset.
  
The last patch was first sent on its own and it was its 5th
version, it has been queued to this patchset as there is a
dependency with it.

Changelog V1 -> V2:

 - patch 1: the exynos5433-spi compatible is placed in
   alphabetical order compared to exynos7-spi

 - patch 1: deprecates exynos7-spi

 - patch 2: [new] added the clocks and clock-name documentation
   in the bindings

 - patch 3: fixed some typos, renamed the goto label from
   err_power_off to err_pm_put add the reviewd-by Krzysztof

 - patch 4: new patch

 - patch 5: fixed typos in commit message and use low letters for
   hex numbers

 - patch 6: removed one line of comment

 - patch 7: added to ensure sequentiality.

Changelog V2 -> V3

 - patch 2: reworded the property descriptions

 - patch 6: reworded the added comment

 - added on all the patches the proper reviewed and acks

Thanks,
Andi

Andi Shyti (7):
  bindings: spi-samsung: add exynos5433 spi compatible
  bindings: spi-samsung: document the clocks and the clock-name property
  spi: s3c64xx: rename goto labels to meaningful names
  spi: s3c64xx: use error code from clk_prepare_enable()
  spi: s3c64xx: add Exynos5433 compatible for ioclk handling
  spi: s3c64xx: restore removed comments
  clk: exynos5433: remove CLK_IGNORE_UNUSED flag from SPI clocks

 .../devicetree/bindings/spi/spi-samsung.txt        | 12 ++-
 drivers/clk/samsung/clk-exynos5433.c               |  5 +-
 drivers/spi/spi-s3c64xx.c                          | 90 +++++++++++++++++-----
 3 files changed, 82 insertions(+), 25 deletions(-)

-- 
2.8.1
