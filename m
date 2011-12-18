From: jamie@jamieiles.com (Jamie Iles)
Date: Sun, 18 Dec 2011 10:59:22 +0000
Subject: [GIT PULL] picoxcell cleanups for 3.3
Message-ID: <20111218105922.GC2376@gallagher>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Please pull these cleanups for picoxcell for the 3.3 merge window.  I've 
based this on Russell's devel-stable branch as they are dependent on the 
VIC changes.

The following changes since commit 3bdc3484e8f2b1b219ad0397d81ce4601fbaf76d:

  ARM: kexec: use soft_restart for branching to the reboot buffer (2011-12-12 16:07:36 +0000)

are available in the git repository at:
  git://github.com/jamieiles/linux-2.6-ji.git picoxcell-cleanup

Jamie Iles (4):
      ARM: picoxcell: remove mach/memory.h
      ARM: picoxcell: don't reserve irq_descs
      ARM: picoxcell: move io mappings to common.c
      MAINTAINERS: add maintainer entry for Picochip picoxcell

 MAINTAINERS                                   |    9 +++++++
 arch/arm/Kconfig                              |    1 +
 arch/arm/mach-picoxcell/Makefile              |    1 -
 arch/arm/mach-picoxcell/common.c              |   15 +++++++++++-
 arch/arm/mach-picoxcell/common.h              |    1 -
 arch/arm/mach-picoxcell/include/mach/irqs.h   |    9 +-----
 arch/arm/mach-picoxcell/include/mach/memory.h |    1 -
 arch/arm/mach-picoxcell/io.c                  |   32 -------------------------
 8 files changed, 26 insertions(+), 43 deletions(-)
 delete mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 delete mode 100644 arch/arm/mach-picoxcell/io.c
