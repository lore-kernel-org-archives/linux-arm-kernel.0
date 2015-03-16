From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 16 Mar 2015 21:51:16 +0100
Subject: [GIT PULL] pxa: for-next v4.1
Message-ID: <87ioe08y4b.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Arnd, Kevin, Olof,

Please consider these pxa for next for v4.1 cycle. This is my leap of faith,
with the conversion of all pxa variants to clock framework. The diffstat is
quite pretty, given all the code moved to drivers/clk.

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.1

for you to fetch changes up to 6fe9642bed2e8760be51d4278a21efccc8cceb06:

  ARM: pxa: Transition pxa25x, pxa27x, pxa3xx to clk framework (2015-03-16 21:35:10 +0100)

----------------------------------------------------------------
This is the pxa changes for v4.1 cycle.

The main and only feature is the conversion of all pxa variants to clock
framework. This encompasses pxa25x, pxa27x and pxa3xx, for all boards.

This should be a disruptive cycle in the normally quiet pxa history, as
the change can break any platform, and the test were performed on only 4
boards (lubbock, zylonite, mioa701, cm-x300).

----------------------------------------------------------------
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
 arch/arm/mach-pxa/lubbock.c      |   4 +-
 arch/arm/mach-pxa/pxa25x.c       | 183 ---------------------------------
 arch/arm/mach-pxa/pxa27x.c       | 182 ++-------------------------------
 arch/arm/mach-pxa/pxa300.c       |  20 +---
 arch/arm/mach-pxa/pxa320.c       |  10 --
 arch/arm/mach-pxa/pxa3xx.c       |  59 -----------
 arch/arm/mach-pxa/raumfeld.c     |   1 -
 arch/arm/mach-pxa/tosa.c         |   1 -
 drivers/clk/pxa/clk-pxa27x.c     |  32 +++++-
 18 files changed, 62 insertions(+), 909 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
 delete mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/clock.c
 delete mode 100644 arch/arm/mach-pxa/clock.h

-- 
Robert
