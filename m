From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 10 Nov 2016 22:24:21 +0900
Subject: [PATCH 0/2] mmc: allow mmc_alloc_host() and tmio_mmc_host_alloc()
Message-ID: <1478784263-18777-1-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


sdhci_alloc_host() returns an error pointer when it fails.
but mmc_alloc_host() cannot.

This series allow to propagate a proper error code
when host-allocation fails.



Masahiro Yamada (2):
  mmc: allow mmc_alloc_host() to return proper error code
  mmc: tmio: allow tmio_mmc_host_alloc() to return proper error code

 drivers/mmc/core/host.c             | 11 ++++++-----
 drivers/mmc/host/android-goldfish.c |  4 ++--
 drivers/mmc/host/atmel-mci.c        |  4 ++--
 drivers/mmc/host/au1xmmc.c          |  4 ++--
 drivers/mmc/host/bfin_sdh.c         |  4 ++--
 drivers/mmc/host/cb710-mmc.c        |  4 ++--
 drivers/mmc/host/davinci_mmc.c      |  4 ++--
 drivers/mmc/host/dw_mmc.c           |  4 ++--
 drivers/mmc/host/jz4740_mmc.c       |  4 ++--
 drivers/mmc/host/mmc_spi.c          |  9 ++++++---
 drivers/mmc/host/mmci.c             |  4 ++--
 drivers/mmc/host/moxart-mmc.c       |  4 ++--
 drivers/mmc/host/mtk-sd.c           |  4 ++--
 drivers/mmc/host/mvsdio.c           |  4 ++--
 drivers/mmc/host/mxcmmc.c           |  4 ++--
 drivers/mmc/host/mxs-mmc.c          |  4 ++--
 drivers/mmc/host/omap.c             |  4 ++--
 drivers/mmc/host/omap_hsmmc.c       |  4 ++--
 drivers/mmc/host/pxamci.c           |  4 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c   |  4 ++--
 drivers/mmc/host/rtsx_usb_sdmmc.c   |  4 ++--
 drivers/mmc/host/s3cmci.c           |  4 ++--
 drivers/mmc/host/sdhci.c            |  4 ++--
 drivers/mmc/host/sdricoh_cs.c       |  4 ++--
 drivers/mmc/host/sh_mmcif.c         |  4 ++--
 drivers/mmc/host/sh_mobile_sdhi.c   |  4 ++--
 drivers/mmc/host/sunxi-mmc.c        |  4 ++--
 drivers/mmc/host/tifm_sd.c          |  4 ++--
 drivers/mmc/host/tmio_mmc.c         |  4 +++-
 drivers/mmc/host/tmio_mmc_pio.c     |  4 ++--
 drivers/mmc/host/toshsd.c           |  4 ++--
 drivers/mmc/host/usdhi6rol0.c       |  4 ++--
 drivers/mmc/host/ushc.c             |  4 ++--
 drivers/mmc/host/via-sdmmc.c        |  4 ++--
 drivers/mmc/host/vub300.c           |  4 ++--
 drivers/mmc/host/wbsd.c             |  4 ++--
 drivers/mmc/host/wmt-sdmmc.c        |  4 ++--
 drivers/staging/greybus/sdio.c      |  4 ++--
 38 files changed, 85 insertions(+), 79 deletions(-)

-- 
1.9.1
