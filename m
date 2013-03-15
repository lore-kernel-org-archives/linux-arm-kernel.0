From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 15 Mar 2013 15:26:59 +0100
Subject: [RFC patch 00/11] cpuidle : ARM driver to rule them all
Message-ID: <1363357630-22214-1-git-send-email-daniel.lezcano@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

At the Linaro Connect Asia 2013, a status of the different cpuidle
drivers available upstream have been presented [1].

It was statued there is a lot of common code, especially in the
init routine, and code duplication (eg. ux500 vs imx6).

The following patchset is the first stone to a single ARM driver
consolidating all the common routine used in the different drivers.

The patchset has been tested on ux500 and at91, compiled on all the other
platforms.

[1] https://lca-13.zerista.com/event/member/72362

Daniel Lezcano (11):
  cpuidle : handle clockevent notify from the cpuidle framework
  cpuidle / arm : a single cpuidle driver
  cpuidle / ux500 : use common ARM cpuidle driver
  cpuidle / omap3 : use common ARM cpuidle driver
  cpuidle / davinci : use common ARM driver
  cpuidle / at91 : use common ARM cpuidle driver
  cpuidle / shmobile : use common ARM cpuidle driver
  cpuidle / imx : use common ARM cpuidle driver
  cpuidle / s3c64xx : use common ARM cpuidle driver
  cpuidle / calxeda : use common ARM cpuidle driver
  cpuidle / kirkwood : use common ARM cpuidle driver

 MAINTAINERS                        |    6 ++
 arch/arm/include/asm/cpuidle.h     |    3 +
 arch/arm/mach-at91/cpuidle.c       |   15 +----
 arch/arm/mach-davinci/cpuidle.c    |   20 +------
 arch/arm/mach-imx/Makefile         |    1 -
 arch/arm/mach-imx/cpuidle-imx6q.c  |   18 +-----
 arch/arm/mach-imx/cpuidle.c        |   80 --------------------------
 arch/arm/mach-imx/cpuidle.h        |    6 +-
 arch/arm/mach-imx/pm-imx5.c        |    3 +-
 arch/arm/mach-omap2/cpuidle34xx.c  |   18 +-----
 arch/arm/mach-s3c64xx/cpuidle.c    |   15 +----
 arch/arm/mach-shmobile/cpuidle.c   |   10 +---
 arch/arm/mach-ux500/cpuidle.c      |   56 +-----------------
 drivers/cpuidle/Makefile           |    1 +
 drivers/cpuidle/arm-idle.c         |  112 ++++++++++++++++++++++++++++++++++++
 drivers/cpuidle/cpuidle-calxeda.c  |   52 +----------------
 drivers/cpuidle/cpuidle-kirkwood.c |   17 +-----
 drivers/cpuidle/cpuidle.c          |    9 +++
 include/linux/cpuidle.h            |    1 +
 19 files changed, 149 insertions(+), 294 deletions(-)
 delete mode 100644 arch/arm/mach-imx/cpuidle.c
 create mode 100644 drivers/cpuidle/arm-idle.c

-- 
1.7.9.5
