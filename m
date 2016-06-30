From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 30 Jun 2016 16:15:09 +0900
Subject: [PATCH v3 0/2] mark spi clocks as critical and enable spi3 clocks
Message-ID: <1467270911-10971-1-git-send-email-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset enables spi3 clocks by marking critical clocks as
CLK_IS_CRITICAL and in the meantime replaces the use of
CLK_IGNORE_UNUSED for spi1 clocks.

The sclk needs to be considered critical as well.

The SPI3 in the tm2/tm2e boards will control an irled for remote
controlling.

Changelog:

V1 -> V2
 - the "sclk_spi3" doesn't need to be enabled in boot time as it
  is handled by the spi driver itself.

 - use the CLK_IS_CRITICAL flag for the ioclk

V2 -> V3
 - some more tests has confirmed taht "sclk_spi1,3" need to be
   enabled as critical!

 - added Chanwoo's review in the second commit.

Thanks,
Andi

Andi Shyti (2):
  clk: exynos5433: do not use CLK_IGNORE_UNUSED for SPI clocks
  clk: exynos5433: enable sclk_ioclk for SPI3

 drivers/clk/samsung/clk-exynos5433.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

-- 
2.8.1
