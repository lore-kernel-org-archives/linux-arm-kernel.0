From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Nov 2016 13:22:20 -0800
Subject: [GIT PULL 2/5] omap soc changes for v4.10
In-Reply-To: <pull-1479236877-351747>
References: <pull-1479236877-351747>
Message-ID: <pull-1479236877-351747-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 1001354ca34179f3db924eb66672442a173147dc:

  Linux 4.9-rc1 (2016-10-15 12:17:50 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.10/soc-signed

for you to fetch changes up to 2bb6375f5c03cc5bf510402b646c1a23046b3f12:

  Merge branch 'omap-for-v4.10/cpuidle-v2' into omap-for-v4.10/soc (2016-11-14 15:58:18 -0800)

----------------------------------------------------------------
SoC changes for omaps for v4.10 merge window:

- Add hwmod interconnect target wrapper module data for crypto
  accelerators for am3xxx, am43xx and dra7

- Add support for dra71x family of SoCs

- PM fixes for omap4/5 needed for omap5 cpuidle

----------------------------------------------------------------
Joel Fernandes (4):
      ARM: DRA7: hwmod: Add data for DES IP
      ARM: DRA7: hwmod: Add data for AES IP
      ARM: DRA7: hwmod: Add data for RNG IP
      ARM: OMAP: DRA7xx: Make L4SEC clock domain SWSUP only

Lokesh Vutla (4):
      ARM: DRA7: hwmod: Add data for SHA IP
      ARM: AM43xx: hwmod: Add data for DES
      ARM: AMx3xx: hwmod: Add data for RNG
      ARM: OMAP2+: board-generic: add support for DRA71x family

Nishanth Menon (1):
      ARM: DRA7: hwmod: Do not register RTC on DRA71

Santosh Shilimkar (1):
      ARM: OMAP5: Add basic cpuidle MPU CSWR support

Tony Lindgren (4):
      ARM: OMAP5: Fix build for PM code
      ARM: OMAP5: Fix mpuss_early_init
      ARM: OMAP4+: Fix bad fallthrough for cpuidle
      Merge branch 'omap-for-v4.10/cpuidle-v2' into omap-for-v4.10/soc

 .../devicetree/bindings/arm/omap/omap.txt          |   6 +
 arch/arm/mach-omap2/Makefile                       |   2 +-
 arch/arm/mach-omap2/board-generic.c                |   1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c         |   2 +-
 arch/arm/mach-omap2/common.h                       |  38 ++++-
 arch/arm/mach-omap2/cpuidle44xx.c                  |  80 ++++++++-
 arch/arm/mach-omap2/io.c                           |   3 +-
 arch/arm/mach-omap2/omap-mpuss-lowpower.c          |  37 +++--
 arch/arm/mach-omap2/omap4-sar-layout.h             |   2 +
 .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  |   2 +
 .../omap_hwmod_33xx_43xx_interconnect_data.c       |   8 +
 .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c |  29 ++++
 arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  35 ----
 arch/arm/mach-omap2/omap_hwmod_43xx_data.c         |  34 ++++
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c          | 182 ++++++++++++++++++++-
 arch/arm/mach-omap2/pm44xx.c                       |   2 +-
 arch/arm/mach-omap2/prcm43xx.h                     |   2 +
 17 files changed, 405 insertions(+), 60 deletions(-)
