From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Mon, 07 Apr 2014 13:53:56 +0200
Subject: [PATCH V2 16/17] ARM: exynos: cpuidle: Move the driver to
 drivers/cpuidle directory
In-Reply-To: <CAK9yfHzXk6ErtmNuT0Z-kMfUGT=GMmFugPR8J=-3SvPMagp6ZA@mail.gmail.com>
References: <1396618989-2897-1-git-send-email-daniel.lezcano@linaro.org>	<1396618989-2897-17-git-send-email-daniel.lezcano@linaro.org>
 <CAK9yfHzXk6ErtmNuT0Z-kMfUGT=GMmFugPR8J=-3SvPMagp6ZA@mail.gmail.com>
Message-ID: <534291D4.1010803@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/07/2014 11:51 AM, Sachin Kamat wrote:
> Hi Daniel,
>
> On 4 April 2014 19:13, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>   arch/arm/mach-exynos/Makefile                      |    1 -
>>   drivers/cpuidle/Kconfig.arm                        |    7 +++++++
>>   drivers/cpuidle/Makefile                           |    1 +
>>   .../cpuidle.c => drivers/cpuidle/cpuidle-exynos.c  |    0
>>   4 files changed, 8 insertions(+), 1 deletion(-)
>>   rename arch/arm/mach-exynos/cpuidle.c => drivers/cpuidle/cpuidle-exynos.c (100%)
>
> This driver now references platform header file (plat/cpu.h) for some
> Exynos5440 specific check
> which is not good considering multiplatform support. Any plan to get
> rid of this?

Yes. Prevent to register the platform device for this board and remove 
these lines in the driver.

What is the benefit of having a single state WFI cpuidle driver ? That 
pulls all the governor computation and decision for nothing.



-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
