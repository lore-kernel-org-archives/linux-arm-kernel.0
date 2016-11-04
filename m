From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Fri, 04 Nov 2016 17:14:47 +0100
Subject: [PATCH RFC 0/7] DMA: S3C64XX: Conversion to the new channel request
 API
In-Reply-To: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
References: <1478276094-19135-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <1478276094-19135-2-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series aims to convert the s3c64xx platform to use
the new universal DMA channel request API, i.e. this is only
meaningful for non-dt systems using s3c64xx SoCs.

I'm sending the whole series as RFC since I didn't test it
yet, I'm going to prepare smd6410 for testing this series.
It would be great if someone else could also test it,
either SPI or sound functionality verification would be 
useful.

Then we could queue the first two patches in this series
for v4.10-rc1 and the remaining patches for subsequent
release.

The whole series can be pulled from git repository:
 git://linuxtv.org/snawrocki/samsung.git 
 branch: for-v4.10/dma/pl080-s3c64xx

Thanks.

Sylwester Nawrocki (7):
  dma: pl08x: Add support for the DMA slave map
  ARM: S3C64XX: Add DMA slave maps for PL080 devices
  spi: s3c64xx: Do not use platform_data for DMA parameters
  ASoC: samsung: i2s: Do not use platform_data for DMA parameters
  ASoC: samsung: pcm: Do not use platform_data for DMA parameters
  ARM: S3C64XX: Drop unused DMA fields from struct s3c64xx_spi_csinfo
  ARM: S3C64XX: Drop initialization of unused struct s3c_audio_pdata
    fields

 arch/arm/mach-s3c64xx/dev-audio.c         | 19 ------------------
 arch/arm/mach-s3c64xx/pl080.c             | 32 +++++++++++++++++++++++++++++++
 arch/arm/plat-samsung/devs.c              |  9 ---------
 drivers/dma/amba-pl08x.c                  |  3 +++
 drivers/spi/spi-s3c64xx.c                 | 21 ++++----------------
 include/linux/amba/pl08x.h                |  4 ++++
 include/linux/platform_data/asoc-s3c.h    |  5 -----
 include/linux/platform_data/spi-s3c64xx.h |  3 ---
 sound/soc/samsung/i2s.c                   | 14 ++------------
 sound/soc/samsung/pcm.c                   | 14 +++++---------
 10 files changed, 50 insertions(+), 74 deletions(-)

-- 
1.9.1
