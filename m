From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 18 Dec 2015 14:40:33 +0100
Subject: [GIT PULL] RealView multiplatform support
Message-ID: <CACRpkdbtieUpUcmWG1KAOet9h+UO-KGTnCrj8OywcxcS77ojcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

Here is the result of my application of the second part of Arnds
patchset, actually enabling multiplatform and getting the RealView
off the ground as a multiplatform target.

It is dependent on an outstanding patch to the irqchips tree bumping
the number of GICs to 2 for the RealView platform. I cannot say I will
be sleepless if these go in side by side: each branch will compile but
will not boot until both trees have been pulled hurting bisectability a
bit.

It is based on the top commit of the previous pull request for the
tag named realview-base-armsoc-1-tag, so it should be possible to
pull in on to of that.

Please resolve and pull this in for v4.5 if you can!

Yours,
Linus Walleij

The following changes since commit 5420b4b156179ec634d9e42279b6898b85852960:

  ARM: realview: add an DT SMP boot method (2015-12-15 09:42:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
tags/realview-multiplatform-tag

for you to fetch changes up to 93b2d7b15af2805ae10db76c651684c5b88b1e9d:

  ARM: realview: select apropriate targets (2015-12-18 14:31:00 +0100)

----------------------------------------------------------------
Multiplatform support for the RealView
- Tested on the ARM PB11MPCore
- Tested with boardfile boot
- Tested with DeviceTree boot

----------------------------------------------------------------
Arnd Bergmann (5):
      ARM: realview: enable multiplatform
      ARM: integrator: use explicit core module options
      ARM: no longer make CPU targets visible separately
      ARM: realview: make all header files local
      ARM: realview: clean up header files

Linus Walleij (1):
      ARM: realview: select apropriate targets

 arch/arm/Kconfig                                   |  14 ---
 arch/arm/configs/realview-smp_defconfig            |   9 ++
 arch/arm/configs/realview_defconfig                |   8 ++
 arch/arm/mach-integrator/Kconfig                   | 132 ++++++++++++++++++---
 arch/arm/mach-realview/Kconfig                     |  55 +++++++--
 arch/arm/mach-realview/Makefile                    |   7 +-
 .../mach-realview/{include/mach => }/board-eb.h    |   4 +-
 .../{include/mach => }/board-pb1176.h              |   4 +-
 .../{include/mach => }/board-pb11mp.h              |   4 +-
 .../mach-realview/{include/mach => }/board-pba8.h  |   4 +-
 .../mach-realview/{include/mach => }/board-pbx.h   |   4 +-
 arch/arm/mach-realview/core.c                      |   6 +-
 arch/arm/mach-realview/core.h                      |   2 -
 .../mach-realview/{include/mach => }/hardware.h    |   2 -
 arch/arm/mach-realview/include/mach/irqs.h         |  40 -------
 arch/arm/mach-realview/include/mach/uncompress.h   |  77 ------------
 .../arm/mach-realview/{include/mach => }/irqs-eb.h |  20 +---
 .../mach-realview/{include/mach => }/irqs-pb1176.h |  23 ----
 .../mach-realview/{include/mach => }/irqs-pb11mp.h |  27 +----
 .../mach-realview/{include/mach => }/irqs-pba8.h   |  23 ----
 .../mach-realview/{include/mach => }/irqs-pbx.h    |  24 +---
 .../mach-realview/{include/mach => }/platform.h    |   2 -
 arch/arm/mach-realview/platsmp.c                   |   8 +-
 arch/arm/mach-realview/realview-dt.c               |   1 -
 arch/arm/mach-realview/realview_eb.c               |   6 +-
 arch/arm/mach-realview/realview_pb1176.c           |   6 +-
 arch/arm/mach-realview/realview_pb11mp.c           |   6 +-
 arch/arm/mach-realview/realview_pba8.c             |   6 +-
 arch/arm/mach-realview/realview_pbx.c              |   6 +-
 arch/arm/mm/Kconfig                                |  30 ++---
 30 files changed, 225 insertions(+), 335 deletions(-)
 rename arch/arm/mach-realview/{include/mach => }/board-eb.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb1176.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pb11mp.h (98%)
 rename arch/arm/mach-realview/{include/mach => }/board-pba8.h (97%)
 rename arch/arm/mach-realview/{include/mach => }/board-pbx.h (98%)
 rename arch/arm/mach-realview/{include/mach => }/hardware.h (95%)
 delete mode 100644 arch/arm/mach-realview/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-realview/include/mach/uncompress.h
 rename arch/arm/mach-realview/{include/mach => }/irqs-eb.h (91%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb1176.h (87%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pb11mp.h (90%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pba8.h (87%)
 rename arch/arm/mach-realview/{include/mach => }/irqs-pbx.h (90%)
 rename arch/arm/mach-realview/{include/mach => }/platform.h (99%)
