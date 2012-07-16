From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 17 Jul 2012 06:59:31 +0900
Subject: [GIT PULL] Samsung DT for v3.6
Message-ID: <143401cd639e$474af610$d5e0e230$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull support samsung spi device tree for v3.6 from:
  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/dt-samsung

It is for supporting spi dt for exynos4210 and exynos5250, and got the ack
from Grant Likely for spi driver.

Note: Since this is including spi driver changes, so it was made based on
next/devel-dma-ops which touches same file, Samsung spi driver for avoiding
bad conflicts.

If any problems, please kindly let me know.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 4d3c463634ba5d0c0f053013cd947721e5e42393:

  Merge branch 'next/devel-dma-ops' into next/dt-samsung (2012-07-13
07:15:08 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
next/dt-samsung

Thomas Abraham (14):
      ARM: S3C64XX: Add a new dma request id for device tree based dma
channel lookup
      spi: s3c64xx: remove unused S3C64XX_SPI_ST_TRLCNTZ macro
      spi: s3c64xx: move controller information into driver data
      ARM: SAMSUNG: Remove pdev pointer parameter from spi gpio setup
functions
      ARM: SAMSUNG: Modify s3c64xx_spi{0|1|2}_set_platdata function
      spi: s3c64xx: Remove the 'set_level' callback from controller data
      spi: s3c64xx: add device tree support
      ARM: EXYNOS: Add device tree node for EXYNOS4 interrupt combiner
controller
      ARM: EXYNOS: Fix the incorrect hierarchy of spi controller bus clock
      ARM: EXYNOS: Enable platform support for SPI controllers for EXYNOX4
      ARM: dts: Add nodes for spi controllers for SAMSUNG EXYNOS4 platforms
      ARM: EXYNOS: Add spi clock support for EXYNOS5
      ARM: EXYNOS: Enable platform support for SPI controllers for EXYNOS5
      ARM: dts: Add nodes for spi controllers for SAMSUNG EXYNOS5 platforms

 .../devicetree/bindings/spi/spi-samsung.txt        |  113 +++++
 arch/arm/boot/dts/exynos4210-origen.dts            |   12 +
 arch/arm/boot/dts/exynos4210-smdkv310.dts          |   38 ++
 arch/arm/boot/dts/exynos4210.dtsi                  |   47 ++
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |   38 ++
 arch/arm/boot/dts/exynos5250.dtsi                  |   36 ++
 arch/arm/mach-exynos/clock-exynos4.c               |   67 ++-
 arch/arm/mach-exynos/clock-exynos5.c               |   95 ++++
 arch/arm/mach-exynos/include/mach/irqs.h           |    4 +
 arch/arm/mach-exynos/include/mach/map.h            |    3 +
 arch/arm/mach-exynos/mach-exynos4-dt.c             |    6 +
 arch/arm/mach-exynos/mach-exynos5-dt.c             |    6 +
 arch/arm/mach-exynos/setup-spi.c                   |   33 +--
 arch/arm/mach-s3c24xx/clock-s3c2416.c              |    3 +-
 arch/arm/mach-s3c24xx/clock-s3c2443.c              |    2 +-
 arch/arm/mach-s3c24xx/common-s3c2443.c             |    4 +-
 arch/arm/mach-s3c24xx/setup-spi.c                  |   10 +-
 arch/arm/mach-s3c64xx/clock.c                      |   20 +-
 arch/arm/mach-s3c64xx/include/mach/dma.h           |    1 +
 arch/arm/mach-s3c64xx/mach-crag6410.c              |    2 +-
 arch/arm/mach-s3c64xx/setup-spi.c                  |   19 +-
 arch/arm/mach-s5p64x0/clock-s5p6440.c              |   12 +-
 arch/arm/mach-s5p64x0/clock-s5p6450.c              |   12 +-
 arch/arm/mach-s5p64x0/setup-spi.c                  |   21 +-
 arch/arm/mach-s5pc100/clock.c                      |   30 +-
 arch/arm/mach-s5pc100/setup-spi.c                  |   30 +--
 arch/arm/mach-s5pv210/clock.c                      |   14 +-
 arch/arm/mach-s5pv210/setup-spi.c                  |   21 +-
 arch/arm/plat-samsung/devs.c                       |   60 +--
 arch/arm/plat-samsung/include/plat/s3c64xx-spi.h   |   39 +--
 drivers/spi/spi-s3c64xx.c                          |  481
+++++++++++++++++---
 31 files changed, 953 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-samsung.txt
