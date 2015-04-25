From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 25 Apr 2015 23:13:20 +0200
Subject: [PATCH v5 0/3] Fix lubbock and mainstone interrupts
Message-ID: <1429996403-13644-1-git-send-email-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie was submitted to the lak list, then migrated to mfd drivers, to end
up again here. There was no change since last submission. Let's hope this is the
last spin and that these platform will be fixed at last.

Robert Jarzmik (3):
  ARM: pxa: pxa_cplds: add lubbock and mainstone IO
  ARM: pxa: mainstone: use new pxa_cplds driver
  ARM: pxa: lubbock: use new pxa_cplds driver

 arch/arm/mach-pxa/Kconfig                  |  10 ++
 arch/arm/mach-pxa/Makefile                 |   1 +
 arch/arm/mach-pxa/include/mach/lubbock.h   |   7 +-
 arch/arm/mach-pxa/include/mach/mainstone.h |   6 +-
 arch/arm/mach-pxa/lubbock.c                | 108 +++++-----------
 arch/arm/mach-pxa/mainstone.c              | 115 ++++-------------
 arch/arm/mach-pxa/pxa_cplds_irqs.c         | 200 +++++++++++++++++++++++++++++
 7 files changed, 275 insertions(+), 172 deletions(-)
 create mode 100644 arch/arm/mach-pxa/pxa_cplds_irqs.c

-- 
2.1.4
