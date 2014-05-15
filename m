From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 15 May 2014 18:13:09 +0900
Subject: [GIT PULL] Samsung fixes for 3.15
Message-ID: <02ae01cf701d$e5761f80$b0625e80$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof, Kevin,

Please pull Samsung fixes and if any problem, please kinldly let me know.

Thanks,
Kukjin

The following changes since commit 89ca3b881987f5a4be4c5dbaa7f0df12bbdde2fd:

  Linux 3.15-rc4 (2014-05-04 18:14:42 -0700)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-fixes

for you to fetch changes up to 702b691e4a711e699cf3cccba879c1d945665c0d:

  ARM: dts: Remove g2d_pd node for exynos5420 (2014-05-15 04:18:24 +0900)

----------------------------------------------------------------
Samsung fixes for 3.15
- Remove g2d_pd and mau_pd nodes on exynos5420.
  Since the power domains are linked to the CMU blocks,
  kernel panic happens during access clocks when the
  power domains are disabled. Now this is a best solution.
- Enable HS-I2C on exynos5 by default
  MMC partition cannot be mounted for RFS without the
  enabling HS-I2C because regulators for MMC power are
  connected to HS-I2C bus.
- Disable MDMA1 node on exynos5420
  When MDMA1 runs in secure mode it makes kernel fault,
  so need to disalbe it on exynos5420 by default instead
  of each board.
- Fix the secondary CPU boot for exynos4212

----------------------------------------------------------------
Arun Kumar K (1):
      ARM: dts: Remove g2d_pd node for exynos5420

Kyungmin Park (1):
      ARM: EXYNOS: fix the secondary CPU boot of exynos4212

Sachin Kamat (1):
      ARM: exynos_defconfig: enable HS-I2C to fix for mmc partition mount

Seungwon Jeon (1):
      ARM: dts: disable MDMA1 node for exynos5420

Tushar Behera (1):
      ARM: dts: Remove mau_pd node for exynos5420

 arch/arm/boot/dts/exynos5420-arndale-octa.dts |   12 ------------
 arch/arm/boot/dts/exynos5420.dtsi             |   18 +++++++-----------
 arch/arm/configs/exynos_defconfig             |    1 +
 arch/arm/mach-exynos/firmware.c               |   15 ++++++++++++++-
 4 files changed, 22 insertions(+), 24 deletions(-)
