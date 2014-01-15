From: lauraa@codeaurora.org (Laura Abbott)
Date: Tue, 14 Jan 2014 21:55:20 -0800
Subject: [RFC 0/2] Early patches to get rid of meminfo
Message-ID: <1389765322-28582-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

With the move away from bootmem and the convergence on memblock, it seems
like meminfo should be deprecated as well to avoid duplication. This is
a first pass attempt to just use memblock and not have meminfo integrated.
There is still a major issue in terms of actually specifying mem at location
on the command line but I wanted to send this out for some early feedback
before putting any more effort into this. I've done basic boot testing on
a simple DT target.

Thanks,
Laura

Laura Abbott (2):
  mm/memblock: add memblock_get_current_limit
  arm: Get rid of meminfo

 arch/arm/include/asm/mach/arch.h         |    4 +-
 arch/arm/include/asm/memblock.h          |    3 +-
 arch/arm/include/asm/setup.h             |   23 ------
 arch/arm/kernel/atags_parse.c            |    5 +-
 arch/arm/kernel/setup.c                  |   33 +++------
 arch/arm/mach-clps711x/board-clep7312.c  |    7 +-
 arch/arm/mach-clps711x/board-edb7211.c   |   10 +--
 arch/arm/mach-clps711x/board-p720t.c     |    2 +-
 arch/arm/mach-footbridge/cats-hw.c       |    2 +-
 arch/arm/mach-footbridge/netwinder-hw.c  |    2 +-
 arch/arm/mach-msm/board-halibut.c        |    6 --
 arch/arm/mach-msm/board-mahimahi.c       |   13 +--
 arch/arm/mach-msm/board-msm7x30.c        |    3 +-
 arch/arm/mach-msm/board-sapphire.c       |   13 +--
 arch/arm/mach-msm/board-trout.c          |    8 +-
 arch/arm/mach-orion5x/common.c           |    3 +-
 arch/arm/mach-orion5x/common.h           |    3 +-
 arch/arm/mach-pxa/cm-x300.c              |    3 +-
 arch/arm/mach-pxa/corgi.c                |   10 +--
 arch/arm/mach-pxa/eseries.c              |    9 +-
 arch/arm/mach-pxa/poodle.c               |    8 +-
 arch/arm/mach-pxa/spitz.c                |    9 +--
 arch/arm/mach-pxa/tosa.c                 |    8 +-
 arch/arm/mach-realview/core.c            |   11 +--
 arch/arm/mach-realview/core.h            |    3 +-
 arch/arm/mach-realview/realview_pb1176.c |    8 +-
 arch/arm/mach-realview/realview_pbx.c    |   17 ++---
 arch/arm/mach-s3c24xx/mach-smdk2413.c    |    8 +-
 arch/arm/mach-s3c24xx/mach-vstms.c       |    8 +-
 arch/arm/mach-sa1100/assabet.c           |    2 +-
 arch/arm/mm/init.c                       |   61 ++++++----------
 arch/arm/mm/mmu.c                        |  122 ++++++++++--------------------
 include/linux/memblock.h                 |    2 +
 mm/memblock.c                            |    5 +
 34 files changed, 150 insertions(+), 284 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
