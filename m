From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 14 May 2014 11:56:24 +0200
Subject: [PATCH v5 0/6] add cpuidle support for Exynos5420
In-Reply-To: <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
References: <ANuQgHGSPJ45tbrVppAVpOqF0OfHacPWfX=S5mOVxTPr66f7vg@mail.gmail.com>
 <1400054637-21505-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <53733DC8.1020608@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2014 10:03 AM, Chander Kashyap wrote:
> Exynos5420 is a big-little Soc from Samsung. It has 4 A15 and 4 A7 cores.
>
> This patchset adds cpuidle support for Exynos5420 SoC based on
> generic big.little cpuidle driver.

Hi Chander,

just a side question. I am not succeeding to have both cluster A7/A15 
with the upstream kernel.

How can I test your driver ?

Did I miss something ?

Thanks
   -- Daniel

> Tested on SMDK5420.
>
> This patch set depends on:
> 	1. [PATCH 0/5] MCPM backend for Exynos5420
> 	   http://www.spinics.net/lists/arm-kernel/msg331100.html
> Changelog is in respective patches.
> Chander Kashyap (5):
>    driver: cpuidle-big-little: add of_device_id structure
>    arm: exynos: add generic function to calculate cpu number
>    cpuidle: config: Add ARCH_EXYNOS entry to select cpuidle-big-little
>      driver
>    driver: cpuidle: cpuidle-big-little: init driver for Exynos5420
>    exynos: cpuidle: do not allow cpuidle registration for Exynos5420
>    mcpm: exynos: populate suspend and powered_up callbacks
>
>   arch/arm/mach-exynos/cpuidle.c       |    3 +++
>   arch/arm/mach-exynos/mcpm-exynos.c   |   36 ++++++++++++++++++++++++++++++++++
>   arch/arm/mach-exynos/regs-pmu.h      |    9 +++++++++
>   drivers/cpuidle/Kconfig.arm          |    2 +-
>   drivers/cpuidle/cpuidle-big_little.c |   12 +++++++++++-
>   5 files changed, 60 insertions(+), 2 deletions(-)
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
