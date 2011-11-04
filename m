From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Fri, 04 Nov 2011 19:26:57 +0530
Subject: [PATCH 0/3] ARM: S5P64X0: Add SDMMC support
Message-ID: <1320415020-7439-1-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for sdhci controller on S5P6440 and S5P6450.

Since this patchset is based on "mmc: sdhci-s3c: Rework platform data 
and add device tree support" clk_type member has been removed from
platform data.

This patchset depends on the patchs:
ARM: S5P64X0: Modified files for SPI consolidation work.
mmc: sdhci-s3c: Rework platform data and add device tree support.

Rajeshwari Shinde (3):
  ARM: S5P64X0: Add HSMMC setup for host Controller
  ARM: S5P64X0: Add lookup of sdhci-s3c clocks using generic names
  ARM: S5P64X0: Enable SDHCI support

 arch/arm/mach-s5p64x0/Kconfig              |   24 +++++++
 arch/arm/mach-s5p64x0/Makefile             |    1 +
 arch/arm/mach-s5p64x0/clock-s5p6440.c      |   72 +++++++++++--------
 arch/arm/mach-s5p64x0/clock-s5p6450.c      |   72 +++++++++++--------
 arch/arm/mach-s5p64x0/cpu.c                |    9 +++
 arch/arm/mach-s5p64x0/mach-smdk6440.c      |   25 +++++++
 arch/arm/mach-s5p64x0/mach-smdk6450.c      |   26 +++++++-
 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c   |  104 ++++++++++++++++++++++++++++
 arch/arm/plat-samsung/include/plat/sdhci.h |   42 +++++++++++
 9 files changed, 314 insertions(+), 61 deletions(-)
 create mode 100644 arch/arm/mach-s5p64x0/setup-sdhci-gpio.c

-- 
1.7.4.4
