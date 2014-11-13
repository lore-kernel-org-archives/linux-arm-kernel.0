From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 13 Nov 2014 18:45:16 +0100
Subject: [GIT PULL] at91: cleanup for 3.18 #2
Message-ID: <1415900716-20882-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Little pull-request with some fixes following the legacy board removal done
earlier. I integrated the patch that Olof wrote in this branch before this series:
please tell me if it works on your side or if I need to do things differently.
The move of header files out of include/mach is useful for reset and memory
drivers.
More legacy code removal is in progress, but I didn't want to mix with this.
So, bigger cleanup to come...

Thanks, best regards,

The following changes since commit 7d7ef547d3fa47ac0df667a6e399eb1ebc60ec2d:

  ARM: at91: fix build breakage due to legacy board removals (2014-11-10 10:38:00 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup2

for you to fetch changes up to f0a0a58e6f46c2dded813ee860b9cbd795b4e571:

  ARM: at91: move sdramc/ddrsdr header to include/soc/at91 (2014-11-13 12:03:44 +0100)

----------------------------------------------------------------
Second batch of cleanup/SoC for 3.19:
- fixes following legacy board removal
- removal of an unused config option CONFIG_MACH_SAMA5_DT
- move of some header files out of include/mach directory

----------------------------------------------------------------
Alexandre Belloni (2):
      ARM: at91: remove CONFIG_MACH_SAMA5_DT
      ARM: at91: move sdramc/ddrsdr header to include/soc/at91

Boris Brezillon (1):
      ARM: at91: remove useless init_time for DT-only SoCs

Nicolas Ferre (1):
      ARM: at91: remove unused CONFIG_ARCH_AT91SAM9G45 option

 MAINTAINERS                                                    |  1 +
 arch/arm/configs/sama5_defconfig                               |  1 -
 arch/arm/mach-at91/Kconfig                                     | 10 +---------
 arch/arm/mach-at91/Makefile                                    |  2 +-
 arch/arm/mach-at91/Makefile.boot                               |  6 ------
 arch/arm/mach-at91/at91sam9g45.c                               |  7 -------
 arch/arm/mach-at91/at91sam9rl.c                                |  7 -------
 arch/arm/mach-at91/board.h                                     |  4 ----
 arch/arm/mach-at91/include/mach/at91_ramc.h                    |  6 +++---
 arch/arm/mach-at91/pm.h                                        |  1 -
 drivers/power/reset/at91-reset.c                               |  4 ++--
 .../include/mach => include/soc/at91}/at91rm9200_sdramc.h      |  0
 .../include/mach => include/soc/at91}/at91sam9_ddrsdr.h        |  0
 .../include/mach => include/soc/at91}/at91sam9_sdramc.h        |  0
 14 files changed, 8 insertions(+), 41 deletions(-)
 rename {arch/arm/mach-at91/include/mach => include/soc/at91}/at91rm9200_sdramc.h (100%)
 rename {arch/arm/mach-at91/include/mach => include/soc/at91}/at91sam9_ddrsdr.h (100%)
 rename {arch/arm/mach-at91/include/mach => include/soc/at91}/at91sam9_sdramc.h (100%)

-- 
Nicolas Ferre
