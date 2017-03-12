From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 12 Mar 2017 11:41:54 +0100
Subject: [GIT PULL] Gemini device tree and multiplatform conversion
Message-ID: <CACRpkdbcJKgk2GzBKQg2zwcrLWVH4=oFQ6bDJ8O-pnhiUUS+Ww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We now have the driver changes upstream to convert the
Gemini to device tree and multiplatform in one swift strike.

I have not included the device tree and bindings in this pull
request, they will be sent in a follow-on pull request.

You can merge this separately or with the device tree
underneath or on top or however you like, what is best for
your patch flow.

As there are some new drivers (based on out-of-tree code
from OpenWRT) we will maybe send more pull requests on
top of this one for these as they get merged into proper
subsystems.

Please pull this into the ARM SoC tree. The DTS pull request
comes soon after this.

Yours,
Linus Walleij

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/gemini-multiplat-dt

for you to fetch changes up to 47d2549ac9be843c7aa1d9472389c644674b218c:

  ARM: gemini: convert to ARMv4 multiplatform (2017-03-12 11:27:53 +0100)

----------------------------------------------------------------
This patchset:

- Converts the Gemini platform to device tree.
- Deletes all the board files.
- Fixes the prerequisities for a multiplatform boot and
  switches to multiplatform.

----------------------------------------------------------------
Linus Walleij (6):
      ARM: gemini: convert to MULTI_IRQ_HANDLER
      ARM: gemini: DT for the Cortina Gemini SoC platforms
      ARM: gemini: delete all boardfiles
      ARM: gemini: switch to sparse IRQs
      ARM: gemini: select ARM_PATCH_PHYS_VIRT and AUTO_ZRELADDR
      ARM: gemini: convert to ARMv4 multiplatform

 arch/arm/Kconfig                                |   9 -
 arch/arm/mach-gemini/Kconfig                    |  53 ++---
 arch/arm/mach-gemini/Makefile                   |  15 +-
 arch/arm/mach-gemini/Makefile.boot              |   9 -
 arch/arm/mach-gemini/board-dt.c                 |  62 ++++++
 arch/arm/mach-gemini/board-nas4220b.c           | 106 ---------
 arch/arm/mach-gemini/board-rut1xx.c             |  92 --------
 arch/arm/mach-gemini/board-wbd111.c             | 133 ------------
 arch/arm/mach-gemini/board-wbd222.c             | 133 ------------
 arch/arm/mach-gemini/common.h                   |  33 ---
 arch/arm/mach-gemini/devices.c                  | 118 ----------
 arch/arm/mach-gemini/gpio.c                     | 231 --------------------
 arch/arm/mach-gemini/idle.c                     |  31 ---
 arch/arm/mach-gemini/include/mach/entry-macro.S |  33 ---
 arch/arm/mach-gemini/include/mach/global_reg.h  | 278 ------------------------
 arch/arm/mach-gemini/include/mach/hardware.h    |  71 ------
 arch/arm/mach-gemini/include/mach/irqs.h        |  53 -----
 arch/arm/mach-gemini/include/mach/uncompress.h  |  42 ----
 arch/arm/mach-gemini/irq.c                      | 105 ---------
 arch/arm/mach-gemini/mm.c                       |  82 -------
 arch/arm/mach-gemini/reset.c                    |  25 ---
 arch/arm/mach-gemini/time.c                     | 239 --------------------
 22 files changed, 77 insertions(+), 1876 deletions(-)
 delete mode 100644 arch/arm/mach-gemini/Makefile.boot
 create mode 100644 arch/arm/mach-gemini/board-dt.c
 delete mode 100644 arch/arm/mach-gemini/board-nas4220b.c
 delete mode 100644 arch/arm/mach-gemini/board-rut1xx.c
 delete mode 100644 arch/arm/mach-gemini/board-wbd111.c
 delete mode 100644 arch/arm/mach-gemini/board-wbd222.c
 delete mode 100644 arch/arm/mach-gemini/common.h
 delete mode 100644 arch/arm/mach-gemini/devices.c
 delete mode 100644 arch/arm/mach-gemini/gpio.c
 delete mode 100644 arch/arm/mach-gemini/idle.c
 delete mode 100644 arch/arm/mach-gemini/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-gemini/include/mach/global_reg.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-gemini/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-gemini/irq.c
 delete mode 100644 arch/arm/mach-gemini/mm.c
 delete mode 100644 arch/arm/mach-gemini/reset.c
 delete mode 100644 arch/arm/mach-gemini/time.c
