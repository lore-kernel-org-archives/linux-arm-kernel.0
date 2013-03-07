From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 7 Mar 2013 03:15:48 +0100
Subject: [GIT PULL] Nomadik multiplatform support for ARM SoC
Message-ID: <CACRpkdbanRz=LuB2nLLso+8iBesy3LwNpqFRSZbDzbcO2Y9sgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

this is a pull request containing multiplatform support for the
Nomadik, targeted
at v3.10, i.e. your multiplatform branch for next.

Not much to say about this, the patches were posted, nobody said anything
and it works fine for me, so please pull it in.

Yours,
Linus Walleij


The following changes since commit 6dbe51c251a327e012439c4772097a13df43c5b8:

  Linux 3.9-rc1 (2013-03-03 15:11:05 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
tags/nomadik-multiplatform

for you to fetch changes up to a2823dd5f5e2f9da2eafc402612ae85526ed222c:

  ARM: nomadik: delete remnant include files (2013-03-07 02:48:03 +0100)

----------------------------------------------------------------
Multiplatform support for the Nomadik
- Get rid of the last header files in the <mach/*> namespace
- Move the debug macro to the common place
- Make the necessary Kconfig fixes and move the platform Kconfig
  fragment down to the mach directory.
- Include necessary defconfig update to get the platform going.

----------------------------------------------------------------
Linus Walleij (4):
      ARM: nomadik: delete IRQ header
      ARM: nomadik: move debugmacro to debug includes
      ARM: nomadik: convert to multiplatform
      ARM: nomadik: delete remnant include files

 arch/arm/Kconfig                                   | 17 -----
 arch/arm/Kconfig.debug                             |  8 +++
 arch/arm/configs/nhk8815_defconfig                 | 42 ++++++------
 .../mach/debug-macro.S => include/debug/nomadik.S} |  0
 arch/arm/mach-nomadik/Kconfig                      | 22 +++++-
 arch/arm/mach-nomadik/Makefile.boot                |  4 --
 arch/arm/mach-nomadik/cpu-8815.c                   |  1 -
 arch/arm/mach-nomadik/include/mach/irqs.h          | 79 ----------------------
 arch/arm/mach-nomadik/include/mach/timex.h         |  6 --
 arch/arm/mach-nomadik/include/mach/uncompress.h    | 60 ----------------
 10 files changed, 46 insertions(+), 193 deletions(-)
 rename arch/arm/{mach-nomadik/include/mach/debug-macro.S =>
include/debug/nomadik.S} (100%)
 delete mode 100644 arch/arm/mach-nomadik/Makefile.boot
 delete mode 100644 arch/arm/mach-nomadik/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/timex.h
 delete mode 100644 arch/arm/mach-nomadik/include/mach/uncompress.h
