From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat,  7 Feb 2015 22:54:01 +0100
Subject: [PATCH 0/2] Switch pxa architecture to clock framework
Message-ID: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is it, everything looks ready for the leap of faith.

This serie removes all legacy clock code, and pxa25x, pxa27x and pxa3xx are
migrated to clock framework. This serie was tested on lubbock (pxa250), mioa701
(pxa270) and zylonite (pxa310). I plan to test also cm-x300 and mainstone in the
near future.

This has the potential to break many pxa boards. The more test it receives, the
better. I'd like this to hit v3.21.

All this work is available here :
  git fetch https://github.com/rjarzmik/linux.git work/clocks-pxa

Cheers.

--
Robert

Robert Jarzmik (2):
  ARM: pxa: convert eseries to clock framework
  ARM: pxa: Transition pxa25x, pxa27x, pxa3xx to clk framework

 arch/arm/Kconfig                 |   2 +-
 arch/arm/mach-pxa/Makefile       |   2 +-
 arch/arm/mach-pxa/clock-pxa2xx.c |  55 ----------
 arch/arm/mach-pxa/clock-pxa3xx.c | 212 ---------------------------------------
 arch/arm/mach-pxa/clock.c        |  86 ----------------
 arch/arm/mach-pxa/clock.h        |  80 ---------------
 arch/arm/mach-pxa/eseries.c      |  22 +---
 arch/arm/mach-pxa/generic.c      |   2 +
 arch/arm/mach-pxa/generic.h      |   1 +
 arch/arm/mach-pxa/lubbock.c      |   1 -
 arch/arm/mach-pxa/pxa25x.c       |   1 -
 arch/arm/mach-pxa/pxa300.c       |  20 +---
 arch/arm/mach-pxa/pxa320.c       |  10 --
 arch/arm/mach-pxa/pxa3xx.c       |  59 -----------
 arch/arm/mach-pxa/raumfeld.c     |   1 -
 arch/arm/mach-pxa/tosa.c         |   1 -
 16 files changed, 8 insertions(+), 547 deletions(-)
 delete mode 100644 arch/arm/mach-pxa/clock-pxa2xx.c
 delete mode 100644 arch/arm/mach-pxa/clock-pxa3xx.c
 delete mode 100644 arch/arm/mach-pxa/clock.c
 delete mode 100644 arch/arm/mach-pxa/clock.h

-- 
2.1.0
