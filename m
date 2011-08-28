From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 28 Aug 2011 02:51:31 +0200
Subject: [PATCH 0/5] Add high resolution generic time support for S3C64xx
Message-ID: <mailman.109.1314794036.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for high resolution generic time on Samsung S3C64xx
SoCs using PWM timers 4 and 5 to implement generic clock source and clock
event device. It also overrides default sched_clock implementation with local
one using the clock source.

Tomasz Figa (5):
  ARM: Samsung: PWM: Allow to differentiate SoCs based on platform
    device name.
  ARM: s3c64xx: Add generic high resolution time support using PWM
    timers.
  ARM: Samsung: pwm: Exclude timer 3 on S3C64xx if generic time is
    enabled.
  ARM: s3c64xx: Move all machines to s3c64xx_timer.
  ARM: s3c64xx: Add optional local sched_clock implementation.

 arch/arm/Kconfig                              |    1 -
 arch/arm/mach-s3c64xx/Kconfig                 |   20 ++
 arch/arm/mach-s3c64xx/Makefile                |    3 +
 arch/arm/mach-s3c64xx/mach-anw6410.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-hmt.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-mini6410.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-ncp.c              |    2 +-
 arch/arm/mach-s3c64xx/mach-real6410.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq5.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smartq7.c          |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6400.c         |    2 +-
 arch/arm/mach-s3c64xx/mach-smdk6410.c         |    2 +-
 arch/arm/mach-s3c64xx/s3c6400.c               |    2 +
 arch/arm/mach-s3c64xx/s3c6410.c               |    2 +
 arch/arm/mach-s3c64xx/time.c                  |  346 +++++++++++++++++++++++++
 arch/arm/plat-samsung/dev-pwm.c               |    8 +
 arch/arm/plat-samsung/include/plat/cpu.h      |    7 +
 arch/arm/plat-samsung/include/plat/pwm-core.h |   21 ++
 arch/arm/plat-samsung/pwm.c                   |   26 ++-
 19 files changed, 443 insertions(+), 11 deletions(-)
 create mode 100644 arch/arm/mach-s3c64xx/time.c
 create mode 100644 arch/arm/plat-samsung/include/plat/pwm-core.h

-- 
1.7.6.1
