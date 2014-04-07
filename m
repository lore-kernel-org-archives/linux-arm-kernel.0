From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Mon, 7 Apr 2014 15:21:37 +0530
Subject: [PATCH V2 16/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle directory
In-Reply-To: <1396618989-2897-17-git-send-email-daniel.lezcano@linaro.org>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>
 <1396618989-2897-17-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAK9yfHzXk6ErtmNuT0Z-kMfUGT=GMmFugPR8J=-3SvPMagp6ZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

On 4 April 2014 19:13, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/arm/mach-exynos/Makefile                      |    1 -
>  drivers/cpuidle/Kconfig.arm                        |    7 +++++++
>  drivers/cpuidle/Makefile                           |    1 +
>  .../cpuidle.c => drivers/cpuidle/cpuidle-exynos.c  |    0
>  4 files changed, 8 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/cpuidle-exynos.c (100%)

This driver now references platform header file (plat/cpu.h) for some
Exynos5440 specific check
which is not good considering multiplatform support. Any plan to get
rid of this?

-- 
With warm regards,
Sachin
