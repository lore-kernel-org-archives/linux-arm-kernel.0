From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 12 Aug 2013 11:41:29 +0200
Subject: [GIT-PULL] cpuidle fixes for 3.12
Message-ID: <5208ADC9.2050309@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit d4e4ab86bcba5a72779c43dc1459f71fea3d89c8:

Linux 3.11-rc5 (2013-08-11 18:04:20 -0700)

are available in the git repository at:

git://git.linaro.org/people/dlezcano/linux.git cpuidle/arm-next

for you to fetch changes up to 75d6137da195a1e059e1c814cb95635e168f85c0:

cpuidle: kirkwood: Make kirkwood_cpuidle_remove function static
(2013-08-12 11:28:50 +0200)

This series fixes some compilation issues:

* for SH, a parameter is missing for the cpuidle_register function
* for Calxeda, an _iomem annotation is missing for scu_base_addr variable
* for kirkwood, a static declaration is missing for the
kirkwood_cpuidle_remove function

Thanks
-- Daniel

----------------------------------------------------------------
Geert Uytterhoeven (1):
SH: cpuidle: Add missing parameter for cpuidle_register()

Jingoo Han (2):
cpuidle: calxeda: Add missing __iomem annotation
cpuidle: kirkwood: Make kirkwood_cpuidle_remove function static

arch/sh/kernel/cpu/shmobile/cpuidle.c | 4 +---
drivers/cpuidle/cpuidle-calxeda.c | 2 +-
drivers/cpuidle/cpuidle-kirkwood.c | 2 +-
3 files changed, 3 insertions(+), 5 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
