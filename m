From: 21cnbao@gmail.com (Barry Song)
Date: Fri, 19 Jul 2013 19:07:16 +0800
Subject: [PATCH 0/6] ASoC: add CSR SiRFSoC sound drivers
Message-ID: <1374232042-26088-1-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds CSR SiRFSoC sound drivers including:
1. the platform DMA driver which will be shard by all DAI
2. the I2S CPU DAI driver
3. the USP-based PCM CPU DAI driver
4. CPU DAI and Codec driver for internal chip codec
5. the mach driver for EVB board using internal codec

Barry Song (1):
  arm: prima2: defconfig: enable sound components

Rongjun Ying (5):
  ASoC: sirf: add sirf platform driver which provides DMA
  ASoC: sirf: add I2S CPU DAI driver
  ASoC: usp-pcm: add CPU DAI driver for PCM simulated from USP
  ASoC: sirf-soc-inner: add drivers for both CPU and Codec DAIs
  ASoC: sirf-inner: add mach driver for SiRFSoC internal codec

 arch/arm/configs/prima2_defconfig |  10 +-
 sound/soc/Kconfig                 |   1 +
 sound/soc/Makefile                |   1 +
 sound/soc/sirf/Kconfig            |  18 ++
 sound/soc/sirf/Makefile           |  11 +
 sound/soc/sirf/sirf-audio.h       | 266 ++++++++++++++++
 sound/soc/sirf/sirf-i2s.c         | 411 ++++++++++++++++++++++++
 sound/soc/sirf/sirf-inner.c       | 267 ++++++++++++++++
 sound/soc/sirf/sirf-pcm.c         | 221 +++++++++++++
 sound/soc/sirf/sirf-pcm.h         |  17 +
 sound/soc/sirf/sirf-soc-inner.c   | 653 ++++++++++++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-usp.c         | 481 ++++++++++++++++++++++++++++
 sound/soc/sirf/sirf-usp.h         | 276 ++++++++++++++++
 13 files changed, 2630 insertions(+), 3 deletions(-)
 create mode 100644 sound/soc/sirf/Kconfig
 create mode 100644 sound/soc/sirf/Makefile
 create mode 100644 sound/soc/sirf/sirf-audio.h
 create mode 100644 sound/soc/sirf/sirf-i2s.c
 create mode 100644 sound/soc/sirf/sirf-inner.c
 create mode 100644 sound/soc/sirf/sirf-pcm.c
 create mode 100644 sound/soc/sirf/sirf-pcm.h
 create mode 100644 sound/soc/sirf/sirf-soc-inner.c
 create mode 100644 sound/soc/sirf/sirf-usp.c
 create mode 100644 sound/soc/sirf/sirf-usp.h

-- 
1.8.2.3
