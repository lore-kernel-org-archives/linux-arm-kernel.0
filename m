From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 8 Apr 2013 17:00:19 +0800
Subject: [GIT PULL 2/4] ARM: mxs: multiplatform for 3.10
In-Reply-To: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
References: <1365411621-18422-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <1365411621-18422-2-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

It's based on mxs-cleanup-3.10 to enable multiplatform build for
mach-mxs. Please pull, thanks.

Shawn

The following changes since commit e933a1a12a02f42e0013cda87bba37ccb59efc47:

  clocksource: mxs_timer: Add semicolon at end of line (2013-04-03 10:30:08 +0800)

are available in the git repository at:

  git://git.linaro.org/people/shawnguo/linux-2.6.git tags/mxs-multiplatform-3.10

for you to fetch changes up to d696e3f6585ddeb7bddbf0783b649fa669459a5c:

  ARM: mxs: enable multiplatform build (2013-04-04 21:15:58 +0800)

----------------------------------------------------------------
The mxs multiplatform support for 3.10:

* It enables the multiplatform build for mach-mxs platform.

----------------------------------------------------------------
Shawn Guo (3):
      ARM: mxs: call mxs_pm_init() as a machine_desc hook
      ARM: mxs: rename debug-macro.S for multiplatform build
      ARM: mxs: enable multiplatform build

 arch/arm/Kconfig                                   |   17 -----
 arch/arm/Kconfig.debug                             |    1 +
 arch/arm/configs/mxs_defconfig                     |    2 +-
 .../mach/debug-macro.S => include/debug/mxs.S}     |    0
 arch/arm/mach-mxs/Kconfig                          |   22 +++---
 arch/arm/mach-mxs/Makefile                         |    2 +-
 arch/arm/mach-mxs/Makefile.boot                    |    1 -
 arch/arm/mach-mxs/include/mach/timex.h             |   21 ------
 arch/arm/mach-mxs/include/mach/uncompress.h        |   76 --------------------
 arch/arm/mach-mxs/mach-mxs.c                       |    3 +
 arch/arm/mach-mxs/pm.c                             |    4 +-
 arch/arm/mach-mxs/pm.h                             |   14 ++++
 12 files changed, 33 insertions(+), 130 deletions(-)
 rename arch/arm/{mach-mxs/include/mach/debug-macro.S => include/debug/mxs.S} (100%)
 delete mode 100644 arch/arm/mach-mxs/Makefile.boot
 delete mode 100644 arch/arm/mach-mxs/include/mach/timex.h
 delete mode 100644 arch/arm/mach-mxs/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-mxs/pm.h
