From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Jul 2014 09:28:47 +0900
Subject: [GIT PULL] Second Round of Renesas ARM Based SoC Updates for v3.17
Message-ID: <cover.1404174157.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Second Round of Renesas ARM Based SoC Updates for v3.17.

This pull request is based on the previous round of
such requests, tagged as renesas-soc-for-v3.17,
which I have already sent a pull-request for.

This conflicts with other changes made to pm-r8a7790.c in the soc branch
of the renesas tree. A resolution can be found in the
renesas-next-v3.16-rc1-20140628 tag of the next branch of that tree.

In short, the resulting includes should be:

#include <linux/kernel.h>
#include <linux/smp.h>
#include <asm/io.h>
#include "common.h"
#include "pm-rcar.h"
#include "r8a7790.h"


The following changes since commit 3ed66ec5ced8b801cb851b2b8548301df94f8f54:

  ARM: shmobile: Remove ARCH_HAS_CPUFREQ config for shmobile (2014-06-23 09:53:55 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc2-for-v3.17

for you to fetch changes up to bfe4cfa8ae21628267f2b879b4396ee17ea4fd3a:

  ARM: shmobile: Allow r8a7791 to build non-SMP APMU code (2014-06-26 16:01:34 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM Based SoC Updates for v3.17

* Suspend on non-SMP update for r8a7790
* Move r8a7791.h out of mach directory.
  This is part of a multi-stage effort to move headers
  out of that directory.

----------------------------------------------------------------
Geert Uytterhoeven (1):
      ARM: shmobile: Move r8a7791.h

Magnus Damm (7):
      ARM: shmobile: Allow use of boot code for non-SMP case
      ARM: shmobile: Adjust APMU code to build for non-SMP
      ARM: shmobile: Use __init for APMU suspend init function
      ARM: shmobile: Move r8a7790 reset code to pm-r8a7790.c
      ARM: shmobile: Allow r8a7790 to build non-SMP APMU code
      ARM: shmobile: Move r8a7791 reset code to pm-r8a7791.c
      ARM: shmobile: Allow r8a7791 to build non-SMP APMU code

 arch/arm/mach-shmobile/Makefile                    | 21 ++++++-----
 arch/arm/mach-shmobile/board-koelsch-reference.c   |  4 ++-
 arch/arm/mach-shmobile/board-koelsch.c             |  4 ++-
 arch/arm/mach-shmobile/headsmp.S                   | 13 ++++---
 arch/arm/mach-shmobile/platsmp-apmu.c              | 13 ++++---
 arch/arm/mach-shmobile/pm-r8a7790.c                | 41 ++++++++++++++++++++--
 arch/arm/mach-shmobile/pm-r8a7791.c                | 30 ++++++++++++++--
 .../arm/mach-shmobile/{include/mach => }/r8a7791.h |  0
 arch/arm/mach-shmobile/setup-r8a7791.c             |  4 ++-
 arch/arm/mach-shmobile/smp-r8a7790.c               | 31 ----------------
 arch/arm/mach-shmobile/smp-r8a7791.c               | 29 ++-------------
 11 files changed, 108 insertions(+), 82 deletions(-)
 rename arch/arm/mach-shmobile/{include/mach => }/r8a7791.h (100%)
