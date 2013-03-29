From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 29 Mar 2013 17:00:56 +0800
Subject: [PATCH 0/3] ARM: mxs: support multiplatform build
Message-ID: <1364547659-30574-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The series is based on mxs cleanup series and enables multiplatform
build for mach-mxs.

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

-- 
1.7.9.5
