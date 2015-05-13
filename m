From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 13 May 2015 23:41:05 +0200
Subject: [GIT PULL] pxa for v4.2
Message-ID: <87a8x8kvf2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Kevin, and Olof,

This is the pxa pull request for 4.2 development cycle. It is the same than the
former 4.1 one, plus a cleanup patch from Krzysztof. As before, this the common
clock framework jump cycle for pxa.

You should be pleased by the diffstat, the former clock submission are paying
now.

The following changes since commit b787f68c36d49bb1d9236f403813641efa74a031:

  Linux 4.1-rc1 (2015-04-26 17:59:10 -0700)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.2

for you to fetch changes up to 64227114c676d9b1fefa4d5070534f3d82d23711:

  ARM: pxa: Constify irq_domain_ops (2015-05-12 23:26:46 +0200)

----------------------------------------------------------------
This is the pxa changes for v4.2 cycle.

The main and only feature is the conversion of all pxa variants to clock
framework. This encompasses pxa25x, pxa27x and pxa3xx, for all boards.

This should be a disruptive cycle in the normally quiet pxa history, as
the change can break any platform, and the test were performed on only 4
boards (lubbock, zylonite, mioa701, cm-x300).

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      ARM: pxa: Constify irq_domain_ops

Robert Jarzmik (7):
      ARM: pxa: change clocks init sequence
      ARM: pxa: move gpio11 clock to board files
      clk: pxa: add missing pxa27x clocks for Irda and sa1100-rtc
      ARM: pxa: pxa27x skip default device initialization with DT
      ARM: pxa: Transition pxa25x and pxa27x to clk framework
      ARM: pxa: convert eseries to clock framework
      ARM: pxa: Transition pxa25x, pxa27x, pxa3xx to clk framework

 arch/arm/Kconfig                 |   1 +
 arch/arm/mach-pxa/Makefile       |   9 +-
 arch/arm/mach-pxa/clock-pxa2xx.c |  55 ----------
 arch/arm/mach-pxa/clock-pxa3xx.c | 212 ---------------------------------------
 arch/arm/mach-pxa/clock.c        |  86 ----------------
 arch/arm/mach-pxa/clock.h        |  80 ---------------
 arch/arm/mach-pxa/eseries.c      |  27 ++---
 arch/arm/mach-pxa/generic.c      |   6 ++
 arch/arm/mach-pxa/generic.h      |   3 +
 arch/arm/mach-pxa/irq.c          |   2 +-
 arch/arm/mach-pxa/lubbock.c      |   4 +-
 arch/arm/mach-pxa/pxa25x.c       | 183 ---------------------------------
 arch/arm/mach-pxa/pxa27x.c       | 182 ++-------------------------------
 arch/arm/mach-pxa/pxa300.c       |  20 +---
 arch/arm/mach-pxa/pxa320.c       |  10 --
 arch/arm/mach-pxa/pxa3xx.c       |  59 -----------
 arch/arm/mach-pxa/raumfeld.c     |   1 -
 arch/arm/mach-pxa/tosa.c         |   1 -
 drivers/clk/pxa/clk-pxa27x.c     |  32 +++++-
 19 files changed, 63 insertions(+), 910 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
 delete mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/clock.c
 delete mode 100644 arch/arm/mach-pxa/clock.h

-- 
Robert
