From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 22:37:53 +0800
Subject: [GIT PULL 2/5] i.MX SoC changes for 4.12
In-Reply-To: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
References: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
Message-ID: <1491835076-1995-2-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-soc-4.12

for you to fetch changes up to ff8abc2839bfab9185978f3c27b5e3b744262efd:

  ARM: mxs: add support for I2SE Duckbill 2 boards (2017-04-10 21:25:50 +0800)

----------------------------------------------------------------
i.MX SoC changes for 4.12:
 - A correction on mmdc_pmu_write_accesses event definition.
 - Add new axi_id perf command to support MMDC filter memory usage
   profiling.
 - Set correct SPI chip_select in platform device registration, so that
   spi-imx driver code can be improved to use chip_select directly for
   harwdare setup instead of indirectly via the cs_gpio mapping array.
 - Disable APIS bus supervisor protect for i.MX25, since the default
   configuration doesn't work for a few peripherals accessed through
   SDMA.
 - Add compatible check for the secondary generation of I2SE i.MX28
   Duckbill board support.

----------------------------------------------------------------
Greg Ungerer (1):
      ARM: imx: set correct chip_select in platform setup

Martin Kaiser (1):
      ARM: i.MX25: globally disable supervisor protect

Michael Heimpold (1):
      ARM: mxs: add support for I2SE Duckbill 2 boards

Tiberiu Breana (2):
      ARM: imx: Fix mmdc_pmu_write_accesses event definition
      ARM: imx: Add AXI address filter support for MMDC profiling

 arch/arm/mach-imx/mach-imx25.c       |  6 ++++++
 arch/arm/mach-imx/mach-mx31_3ds.c    |  7 +++++--
 arch/arm/mach-imx/mach-mx31moboard.c |  4 ++--
 arch/arm/mach-imx/mach-pcm037_eet.c  |  4 ++--
 arch/arm/mach-imx/mmdc.c             | 20 +++++++++++++++++++-
 arch/arm/mach-mxs/mach-mxs.c         |  3 ++-
 6 files changed, 36 insertions(+), 8 deletions(-)
