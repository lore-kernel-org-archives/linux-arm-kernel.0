From: kgene@kernel.org (Kukjin Kim)
Date: Thu, 12 Mar 2015 20:04:18 +0900
Subject: [GIT PULL] Exynos fixes for v4.0
In-Reply-To: <1426083637.24734.14.camel@AMDC1943>
References: <1426083637.24734.14.camel@AMDC1943>
Message-ID: <021d01d05cb4$49599260$dc0cb720$@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Krzysztof Kozlowski wrote:
> 
> Dear Kukjin,
> 
Hi,

> This groups important fixes for this v4.0-rc cycle. I hope you will find
> useful such grouping them in a pull request.
> 
Thanks for your gentle reminder :-)

> 1. Fix second suspend to RAM on Trats2 board. This has shown up
>    after enabling L2 cache but actually the "use delayed reset
>    assertion" is to be blamed.
> 2. Fix power domain issues with disp1 domain and HDMI (some of them)
>    on Odroid XU3:
>    - disp1 power domain can be turned off,
>    - no more "imprecise external abort" faults.
> 3. Proper fix for build breakage of cpuidle on !SMP. This allows using
>    Exynos cpuidle driver on UP.
> 
> Best regards,
> Krzysztof
> 
> ----------------------------------------------------------------
> 
> The following changes since commit 2d2c9a8d0a4f90e298315d2f4a282d8bd5d45e5c:
> 
>   ARM: dts: add display power domain for exynos5250 (2015-02-27 05:29:32 +0900)
> 
> are available in the git repository at:
> 
>   git://git.linaro.org/people/marek.szyprowski/linux-srpol.git v4.0-rc1-exynos-fixes
> 
> for you to fetch changes up to c1b57bce36a69f3972a1db433d3c8b34e0541e63:
> 
>   ARM: EXYNOS: cpuidle: Fix build breakage on !SMP (2015-03-11 13:02:08 +0100)
> 
> ----------------------------------------------------------------
> Andrzej Hajda (4):
>       arm/exynos: add asynchronous bridge clock bindings
>       arm/exynos/pm_domains: add support for async-bridge clocks
>       ARM: dts: exynos5420: add async-bridge clocks to disp1 power domain
>       ARM: dts: exynos5420: add async-bridge clocks to gsc power domain
> 
When I checked the patches, I expected that we could get the review from clock
guys even we could do it though. And basically/usually the 'RFC' tagging means
it's not a patch can be upstreamed and will be posted after gathering some
comments so I didn't queue them in my tree. I'm still thinking like that...

> Bartlomiej Zolnierkiewicz (1):
>       ARM: EXYNOS: cpuidle: Fix build breakage on !SMP
> 
Yeah, we need to fix it up asap and I'll finish it by this weekend. Sorry for
the inconvenience.

> Krzysztof Kozlowski (1):
>       ARM: EXYNOS: Fix failed second suspend on Exynos4
> 
I'll have a look at this with above.

Thanks,
Kukjin

>  .../bindings/arm/exynos/power_domain.txt           |  3 ++
>  arch/arm/boot/dts/exynos5420.dtsi                  |  8 +++--
>  arch/arm/mach-exynos/common.h                      |  2 ++
>  arch/arm/mach-exynos/exynos.c                      | 29 +++++++++++++++-
>  arch/arm/mach-exynos/platsmp.c                     | 39 ++--------------------
>  arch/arm/mach-exynos/pm.c                          |  2 ++
>  arch/arm/mach-exynos/pm_domains.c                  | 27 ++++++++++++---
>  arch/arm/mach-exynos/suspend.c                     |  3 ++
>  drivers/cpuidle/cpuidle-exynos.c                   |  3 +-
>  9 files changed, 71 insertions(+), 45 deletions(-)
