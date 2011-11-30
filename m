From: jtzhou@marvell.com (Jett.Zhou)
Date: Wed, 30 Nov 2011 12:26:20 +0800
Subject: [V3 0/6] rtc-sa1100 clean up 
Message-ID: <1322627186-32345-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set do the following things:
  1) clean up sa1100-rtc for support sa1100/pxa/mmp series
  2) add dummy clock for pxa arch
  3) clean up clock dev for sa1100 arch and add dummy clock for sa1100
  4) fix build error for sa1100 arch

Jett.Zhou (6):
  RTC: sa1100: Clean out ost register
  RTC: sa1100: remove redundant code of setting alarm
  RTC: sa1100: support sa1100, pxa and mmp soc families
  ARM: pxa: add dummy clock for sa1100-rtc
  ARM: sa1100: clean up of the clock support
  ARM: sa1100: fix build error

 arch/arm/Kconfig                   |    2 +-
 arch/arm/mach-pxa/devices.c        |   20 +++
 arch/arm/mach-pxa/pxa25x.c         |    1 +
 arch/arm/mach-pxa/pxa27x.c         |    1 +
 arch/arm/mach-pxa/pxa300.c         |    1 +
 arch/arm/mach-pxa/pxa320.c         |    1 +
 arch/arm/mach-pxa/pxa3xx.c         |    1 +
 arch/arm/mach-pxa/pxa95x.c         |    1 +
 arch/arm/mach-sa1100/Makefile.boot |    4 +-
 arch/arm/mach-sa1100/clock.c       |   91 ++++++++---
 arch/arm/mach-sa1100/generic.c     |   20 +++
 drivers/rtc/Kconfig                |    2 +-
 drivers/rtc/rtc-sa1100.c           |  300 ++++++++++++++++++++++--------------
 13 files changed, 299 insertions(+), 146 deletions(-)
