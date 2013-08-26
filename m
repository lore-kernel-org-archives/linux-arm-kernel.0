From: tony@atomide.com (Tony Lindgren)
Date: Mon, 26 Aug 2013 07:21:36 -0700
Subject: [GIT PULL 2/2] late dra7xx PRCM and hwmod support for v3.12 merge
 window
In-Reply-To: <pull-1377526896-974252>
Message-ID: <mailman.1.1377526945.1056.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit cf470a1b1a741bca00080ebc70968b4f22d9b1ea:

  Merge tag 'dra7-core-support-minus-dt' of git://github.com/rrnayak/linux into omap-for-v3.12/soc (2013-08-14 01:01:41 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.12/dra7xx-prcm

for you to fetch changes up to e3e1970f892d873e0f01c4516eaf986ae3a91e13:

  Merge tag 'for-v3.12/dra7xx' of git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into omap-for-v3.12/soc (2013-08-26 02:53:05 -0700)

----------------------------------------------------------------

Add basic support for devices on dra7xx by adding the PRCM and hwmod
parts the same way as for other omaps. This is still needed in
addition to device tree support for things like power management.

Via Paul Walmsley <paul@pwsan.com>:

This series adds basic TI DRA7xx PRCM and hwmod support.

Basic test logs are available here:

http://www.pwsan.com/omap/testlogs/dra7xx_prcm_devel_v3.12/20130823050445/

Note that DRA7xx could not be tested locally, since I don't have a board.

----------------------------------------------------------------
Ambresh K (7):
      ARM: OMAP: DRA7: PRM: Add DRA7XX register definitions
      ARM: OMAP: DRA7: CM: Add DRA7XX register defines
      ARM: OMAP: DRA7: PRCM: Add DRA7XX local MPU PRCM regsiters
      ARM: OMAP: DRA7: clockdomain: Add DRA7XX data and update header
      ARM: OMAP: DRA7: powerdomain: Add DRA7XX data and update header
      ARM: OMAP: DRA7: hwmod: Create initial DRA7XX SoC data
      ARM: OMAP: DRA7: Enable PM framework initializations

Rajendra Nayak (3):
      ARM: OMAP: DRA7: CM: Add minimal regbit shifts
      ARM: OMAP: DRA7: powerdomain: Handle missing vc/vp
      ARM: OMAP: DRA7: Reuse the omap44xx_restart and fix the device instance

Tony Lindgren (1):
      Merge tag 'for-v3.12/dra7xx' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.12/soc

 arch/arm/mach-omap2/Makefile               |    4 +
 arch/arm/mach-omap2/board-generic.c        |    1 +
 arch/arm/mach-omap2/clockdomain.h          |    1 +
 arch/arm/mach-omap2/clockdomains7xx_data.c |  740 ++++++++
 arch/arm/mach-omap2/cm-regbits-7xx.h       |   51 +
 arch/arm/mach-omap2/cm1_7xx.h              |  324 ++++
 arch/arm/mach-omap2/cm2_7xx.h              |  513 ++++++
 arch/arm/mach-omap2/io.c                   |    5 +
 arch/arm/mach-omap2/omap_hwmod.h           |    1 +
 arch/arm/mach-omap2/omap_hwmod_7xx_data.c  | 2724 ++++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomain.h          |    1 +
 arch/arm/mach-omap2/powerdomains7xx_data.c |  454 +++++
 arch/arm/mach-omap2/prcm44xx.h             |    5 +
 arch/arm/mach-omap2/prcm_mpu7xx.h          |   78 +
 arch/arm/mach-omap2/prm44xx.c              |   12 +-
 arch/arm/mach-omap2/prm7xx.h               |  678 +++++++
 arch/arm/mach-omap2/prminst44xx.c          |   20 +-
 17 files changed, 5607 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-omap2/clockdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/cm-regbits-7xx.h
 create mode 100644 arch/arm/mach-omap2/cm1_7xx.h
 create mode 100644 arch/arm/mach-omap2/cm2_7xx.h
 create mode 100644 arch/arm/mach-omap2/omap_hwmod_7xx_data.c
 create mode 100644 arch/arm/mach-omap2/powerdomains7xx_data.c
 create mode 100644 arch/arm/mach-omap2/prcm_mpu7xx.h
 create mode 100644 arch/arm/mach-omap2/prm7xx.h
