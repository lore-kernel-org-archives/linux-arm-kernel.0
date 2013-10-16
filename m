From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 17 Oct 2013 00:09:05 +0200
Subject: [GIT PULL] ARM: cpuidle: at91 platform driver conversion
Message-ID: <525F0E81.5030002@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Rafael,

This pull request based on the pm-cpuidle branch contains the following:

  * Daniel Lezcano converted cpuidle to a platform_driver for at91. The 
standby callback is stored in the platform_device's data field as a 
callback for the driver, so the pm specific code and the backend driver 
have no more dependency. Each SoC init function fills the right callback 
at init time. As there are no more dependency, we can move the driver in 
the drivers/cpuidle directory.

  * Jean-Christophe Plagnol-Villard and Nicolas Ferre made a cleanup on 
top of the patch described above and fixed up the ddr standby callback 
so more SoC are supported. Even if the modifications are in the 
mach-at91 directory, they asked these patches to be included through the 
PM tree as they depend on the platform_driver conversion.

Thanks !
   -- Daniel


The following changes since commit ac9f1cc2ce1a178696763444f2a2f8a0ec661772:

   Merge back earlier cpuidle material for v3.13. (2013-10-07 21:31:21 
+0200)

are available in the git repository at:


   git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 6b625891c6b541080bdaad97bcb82bd9ecd9e44b:

   ARM: AT91: DT: pm: Select ram controller standby based on DT 
(2013-10-16 23:51:47 +0200)

----------------------------------------------------------------
Daniel Lezcano (2):
       ARM: at91: cpuidle: Convert to platform driver
       ARM: at91: cpuidle: Move driver to drivers/cpuidle

Jean-Christophe PLAGNIOL-VILLARD (2):
       ARM: AT91: pm: Factorize standby function
       ARM: AT91: DT: pm: Select ram controller standby based on DT

  arch/arm/mach-at91/Makefile                        |    1 -
  arch/arm/mach-at91/at91rm9200.c                    |    2 +
  arch/arm/mach-at91/at91sam9260.c                   |    2 +
  arch/arm/mach-at91/at91sam9261.c                   |    2 +
  arch/arm/mach-at91/at91sam9263.c                   |    2 +
  arch/arm/mach-at91/at91sam9g45.c                   |    2 +
  arch/arm/mach-at91/at91sam9rl.c                    |    2 +
  arch/arm/mach-at91/pm.c                            |   27 ++++++---
  arch/arm/mach-at91/pm.h                            |   59 
++++++++++----------
  arch/arm/mach-at91/setup.c                         |   14 ++++-
  drivers/cpuidle/Kconfig.arm                        |    7 +++
  drivers/cpuidle/Makefile                           |    1 +
  .../cpuidle.c => drivers/cpuidle/cpuidle-at91.c    |   29 +++++-----
  13 files changed, 93 insertions(+), 57 deletions(-)
  rename arch/arm/mach-at91/cpuidle.c => drivers/cpuidle/cpuidle-at91.c 
(79%)


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
