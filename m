From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Mon, 08 Aug 2011 14:17:50 +0530
Subject: RFC[PATCH 0/6] ARM: S5P64X0: Add SDHCI support using clkdev
Message-ID: <1312793277-18689-1-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

S5P64X0 supports 3 Channel MMC/SDHCI/SDIO.
This patchset adds the pin-mux setup and enables the HSMMC device
for S5P64X0 using clkdev support.

This patch series is based on the latest
git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git for-next
Tested on SMDK6440 and SMDK6450.

Rajeshwari Shinde (6):

o To Ben Dooks, Chris Ball 
  SDHCI: S3C: Use bus clocks created using clkdev

o To Kukjin Kim
  ARM: S5P64X0: Enable SDHCI device
  ARM: S5P64X0: Add support for pin-mux setup for SDHCI controllers
  ARM: S5P64X0: Populate default platform data for SDHCI devices
  ARM: S5P64X0: Enable SDHCI support
  ARM: S5P64X0: Add clkdev bus lookup support

 arch/arm/mach-s5p64x0/Kconfig                      |   30 ++++++
 arch/arm/mach-s5p64x0/Makefile                     |    2 +
 arch/arm/mach-s5p64x0/cpu.c                        |    9 ++
 .../include/mach/s5p64x0-common-sdhci.h            |   17 +++
 arch/arm/mach-s5p64x0/mach-smdk6440.c              |   15 +++
 arch/arm/mach-s5p64x0/mach-smdk6450.c              |   15 +++
 arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c       |   41 ++++++++
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c           |  109 ++++++++++++++++++++
 arch/arm/mach-s5p64x0/setup-sdhci.c                |   46 ++++++++
 arch/arm/plat-samsung/Makefile                     |    1 +
 arch/arm/plat-samsung/clkdev-busalias.c            |   44 ++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h         |   58 +++++++++++
 drivers/mmc/host/sdhci-s3c.c                       |    6 +-
 13 files changed, 389 insertions(+), 4 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/include/mach/s5p64x0-common-sdhci.h
 create mode 100644 arch/arm/mach-s5p64x0/s5p64x0-common-sdhci.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c
 create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci.c
 create mode 100644 arch/arm/plat-samsung/clkdev-busalias.c

-- 
1.7.4.4
