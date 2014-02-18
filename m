From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 18 Feb 2014 14:15:31 -0800
Subject: [PATCHv4 0/2] Remove ARM meminfo
Message-ID: <1392761733-32628-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is v4 of meminfo removal to fix a few additional issues.
Review/test away.

Thanks,
Laura


v4: Added nommu support. Fixed issues with !HIGHMEM per Grygorii Strashko.

v3: Fixed compilation issue for CONFIG_SPARSEMEM. Fixed several typos
in spitz.c. Removed early_init_dt_add_memory_arch per Grant's suggestion.

v2: Implemented full commandline support for mem at addr



Laura Abbott (2):
  mm/memblock: add memblock_get_current_limit
  arm: Get rid of meminfo

 arch/arm/include/asm/mach/arch.h         |    4 +-
 arch/arm/include/asm/memblock.h          |    3 +-
 arch/arm/include/asm/setup.h             |   23 ------
 arch/arm/kernel/atags_parse.c            |    5 +-
 arch/arm/kernel/devtree.c                |    5 --
 arch/arm/kernel/setup.c                  |   30 ++------
 arch/arm/mach-clps711x/board-clep7312.c  |    7 +-
 arch/arm/mach-clps711x/board-edb7211.c   |   10 +--
 arch/arm/mach-clps711x/board-p720t.c     |    2 +-
 arch/arm/mach-footbridge/cats-hw.c       |    2 +-
 arch/arm/mach-footbridge/netwinder-hw.c  |    2 +-
 arch/arm/mach-msm/board-halibut.c        |    6 --
 arch/arm/mach-msm/board-mahimahi.c       |   13 +---
 arch/arm/mach-msm/board-msm7x30.c        |    3 +-
 arch/arm/mach-msm/board-sapphire.c       |   13 ++--
 arch/arm/mach-msm/board-trout.c          |    8 +--
 arch/arm/mach-orion5x/common.c           |    3 +-
 arch/arm/mach-orion5x/common.h           |    3 +-
 arch/arm/mach-pxa/cm-x300.c              |    3 +-
 arch/arm/mach-pxa/corgi.c                |   10 +--
 arch/arm/mach-pxa/eseries.c              |    9 +--
 arch/arm/mach-pxa/poodle.c               |    8 +--
 arch/arm/mach-pxa/spitz.c                |    8 +--
 arch/arm/mach-pxa/tosa.c                 |    8 +--
 arch/arm/mach-realview/core.c            |   11 +--
 arch/arm/mach-realview/core.h            |    3 +-
 arch/arm/mach-realview/realview_pb1176.c |    8 +--
 arch/arm/mach-realview/realview_pbx.c    |   17 ++---
 arch/arm/mach-s3c24xx/mach-smdk2413.c    |    8 +--
 arch/arm/mach-s3c24xx/mach-vstms.c       |    8 +--
 arch/arm/mach-sa1100/assabet.c           |    2 +-
 arch/arm/mm/init.c                       |   67 +++++++-----------
 arch/arm/mm/mmu.c                        |  115 +++++++++---------------------
 arch/arm/mm/nommu.c                      |   66 +++++++++--------
 include/linux/memblock.h                 |    2 +
 mm/memblock.c                            |    5 ++
 36 files changed, 179 insertions(+), 321 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
