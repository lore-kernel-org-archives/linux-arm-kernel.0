From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 24 Feb 2014 14:40:58 +0900
Subject: [PATCH 00/12] ARM: shmobile: Rework include path for SoC files
Message-ID: <20140224054058.1143.14096.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM: shmobile: Rework include path for SoC files

[PATCH 01/12] ARM: shmobile: Add temporary include workaround
[PATCH 02/12] ARM: shmobile: Rework include path for sh7372
[PATCH 03/12] ARM: shmobile: Rework include path for sh73a0
[PATCH 04/12] ARM: shmobile: Rework include path for EMEV2
[PATCH 05/12] ARM: shmobile: Rework include path for r8a7740
[PATCH 06/12] ARM: shmobile: Rework include path for r8a7778
[PATCH 07/12] ARM: shmobile: Rework include path for r8a7779
[PATCH 08/12] ARM: shmobile: Rework include path for r8a7790
[PATCH 09/12] ARM: shmobile: Rework include path for r8a7791
[PATCH 10/12] ARM: shmobile: Rework include path for r8a73a4
[PATCH 11/12] ARM: shmobile: Rework include path for r7s72100
[PATCH 12/12] ARM: shmobile: Rework include path for common bits

Start converting the mach-shmobile subarchitecture from <mach/something.h>
to "something.h". This series covers shared code base and SoC code,
however actual header files are not moved yet. Upcoming series that
depend on this one will have to convert board code as well. When SoCs
code and board code have been converted then actual header files can
be moved and temporary include path workarounds can be removed.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written against renesas.git tag renesas-devel-v3.14-rc3-20140224

 arch/arm/mach-shmobile/Makefile          |    2 ++
 arch/arm/mach-shmobile/clock-emev2.c     |    2 +-
 arch/arm/mach-shmobile/clock-r7s72100.c  |    4 ++--
 arch/arm/mach-shmobile/clock-r8a73a4.c   |    4 ++--
 arch/arm/mach-shmobile/clock-r8a7740.c   |    6 +++---
 arch/arm/mach-shmobile/clock-r8a7778.c   |    4 ++--
 arch/arm/mach-shmobile/clock-r8a7779.c   |    4 ++--
 arch/arm/mach-shmobile/clock-r8a7790.c   |    6 +++---
 arch/arm/mach-shmobile/clock-r8a7791.c   |    4 ++--
 arch/arm/mach-shmobile/clock-sh7372.c    |    4 ++--
 arch/arm/mach-shmobile/clock-sh73a0.c    |    4 ++--
 arch/arm/mach-shmobile/clock.c           |    4 ++--
 arch/arm/mach-shmobile/console.c         |    2 +-
 arch/arm/mach-shmobile/intc-sh7372.c     |    4 ++--
 arch/arm/mach-shmobile/intc-sh73a0.c     |    6 +++---
 arch/arm/mach-shmobile/platsmp-apmu.c    |    2 +-
 arch/arm/mach-shmobile/platsmp-scu.c     |    2 +-
 arch/arm/mach-shmobile/platsmp.c         |    2 +-
 arch/arm/mach-shmobile/pm-r8a7740.c      |    4 ++--
 arch/arm/mach-shmobile/pm-r8a7779.c      |    6 +++---
 arch/arm/mach-shmobile/pm-r8a7790.c      |    4 ++--
 arch/arm/mach-shmobile/pm-rcar.c         |    2 +-
 arch/arm/mach-shmobile/pm-rmobile.c      |    2 +-
 arch/arm/mach-shmobile/pm-sh7372.c       |    6 +++---
 arch/arm/mach-shmobile/pm-sh73a0.c       |    2 +-
 arch/arm/mach-shmobile/setup-emev2.c     |    4 ++--
 arch/arm/mach-shmobile/setup-r7s72100.c  |    6 +++---
 arch/arm/mach-shmobile/setup-r8a73a4.c   |    8 ++++----
 arch/arm/mach-shmobile/setup-r8a7740.c   |   10 +++++-----
 arch/arm/mach-shmobile/setup-r8a7778.c   |    6 +++---
 arch/arm/mach-shmobile/setup-r8a7779.c   |    6 +++---
 arch/arm/mach-shmobile/setup-r8a7790.c   |    8 ++++----
 arch/arm/mach-shmobile/setup-r8a7791.c   |    8 ++++----
 arch/arm/mach-shmobile/setup-rcar-gen2.c |    4 ++--
 arch/arm/mach-shmobile/setup-sh7372.c    |    8 ++++----
 arch/arm/mach-shmobile/setup-sh73a0.c    |    8 ++++----
 arch/arm/mach-shmobile/smp-emev2.c       |    4 ++--
 arch/arm/mach-shmobile/smp-r8a7779.c     |    6 +++---
 arch/arm/mach-shmobile/smp-r8a7790.c     |    6 +++---
 arch/arm/mach-shmobile/smp-r8a7791.c     |    4 ++--
 arch/arm/mach-shmobile/smp-sh73a0.c      |    4 ++--
 41 files changed, 97 insertions(+), 95 deletions(-)
