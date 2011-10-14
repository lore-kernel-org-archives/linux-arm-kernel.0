From: rajeshwari.s@samsung.com (Rajeshwari Shinde)
Date: Fri, 14 Oct 2011 15:58:43 +0530
Subject: [PATCH V5 0/3] ARM: SAMSUNG: Add support for sdhci clock lookup using
	generic names
Message-ID: <1318588126-19167-1-git-send-email-rajeshwari.s@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for sdhci controller clock lookup using
generic names. With this patchset, there will be no need to pass clock
names in sdhci platform data.

This patchset depends on the patchset:
Add a common macro for creating struct clk_lookup entries.
mmc: sdhci-s3c: add default controller configuration.

V2 Changes:
- Added HCLK instance for HSMMC instance 1 as suggested by Heiko.
- Rebased on UART clkdev patches. So these patches should be applied
 after UART clkdev patches are applied.

V3 Changes:
- Removed double registration of hsmmc1 hclk from s3c2416 as suggested by
 Heiko

V4 Changes:
- Changed the devname for bus clocks in Exynos4 to s3c-sdhci. from
 exynos4-sdhci. as suggested by Sylwester.

V5 Changes:
- Rebased the patches on latest For-next branch of Kgene's tree
 after "S3C2416: Enable armdiv and armclk" patch by Heiko. 

Rajeshwari Shinde (3):
  SDHCI: S3C: Use generic clock names for sdhci bus clock options
  ARM: SAMSUNG: Remove SDHCI bus clocks from platform data
  ARM: SAMSUNG: Add lookup of sdhci-s3c clocks using generic names

 arch/arm/mach-exynos4/Makefile             |    1 -
 arch/arm/mach-exynos4/clock.c              |   88 +++++++++------
 arch/arm/mach-exynos4/setup-sdhci.c        |   22 ----
 arch/arm/mach-s3c2416/Makefile             |    1 -
 arch/arm/mach-s3c2416/clock.c              |   68 ++++++-----
 arch/arm/mach-s3c2416/setup-sdhci.c        |   24 ----
 arch/arm/mach-s3c64xx/Makefile             |    1 -
 arch/arm/mach-s3c64xx/clock.c              |  126 +++++++++++++--------
 arch/arm/mach-s3c64xx/setup-sdhci.c        |   24 ----
 arch/arm/mach-s5pc100/Makefile             |    1 -
 arch/arm/mach-s5pc100/clock.c              |  130 +++++++++++++---------
 arch/arm/mach-s5pc100/setup-sdhci.c        |   23 ----
 arch/arm/mach-s5pv210/Makefile             |    1 -
 arch/arm/mach-s5pv210/clock.c              |  167 +++++++++++++++++-----------
 arch/arm/mach-s5pv210/setup-sdhci.c        |   22 ----
 arch/arm/plat-s3c24xx/s3c2443-clock.c      |   16 ++-
 arch/arm/plat-samsung/include/plat/sdhci.h |   31 -----
 drivers/mmc/host/sdhci-s3c.c               |    6 +-
 18 files changed, 361 insertions(+), 391 deletions(-)
 delete mode 100644 arch/arm/mach-exynos4/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c2416/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s3c64xx/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pc100/setup-sdhci.c
 delete mode 100644 arch/arm/mach-s5pv210/setup-sdhci.c

-- 
1.7.4.4
