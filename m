From: kgene.kim@samsung.com (Kukjin Kim)
Date: Tue, 15 Mar 2011 21:50:36 +0900
Subject: [PATCH v2 0/4] S5PC210/S5PV310/EXYNOS4 interrupts update
In-Reply-To: <1300086286-9006-1-git-send-email-m.szyprowski@samsung.com>
References: <1300086286-9006-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <011201cbe30f$9728d000$c57a7000$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> This patch series perform an update on interrupts support for
> S5PC210/S5PV310/EXYNOS4 platform. An optional support for GPIO
> interrupts handler has been added The patches have been prepared to
> maximise the code reuse, so common code for gpio interrupts for s5pc100,
> s5pc110 & s5pc210 have been prepared.
> 
> The patches have been prepared against
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-next branch (commit be7004f73d0).
> 
> Patches that make use of these optional features for universal c210
> board will follow soon.
> 
> Changes since v1:
> - rebased onto latest version of kgene/for-next kernel tree (with s5pv310
>   to exynos4 rename)
> - removed machine specific interrupt patch from this patch series
> 
> Patch summary:
> 
> Marek Szyprowski (4):
>   ARM: EXYNOS4: Add missing GPYx banks.
>   ARM: Samsung: cleanup S5P gpio interrupt code
>   ARM: Samsung: add function to register gpio interrupt bank data
>   ARM: EXYNOS4: add support for gpio interrupts
> 
>  arch/arm/mach-exynos4/gpiolib.c               |   67 ++++++++++-
>  arch/arm/mach-exynos4/include/mach/gpio.h     |   23 ++++-
>  arch/arm/mach-exynos4/include/mach/irqs.h     |   12 ++-
>  arch/arm/mach-s5pc100/gpiolib.c               |    1 +
>  arch/arm/mach-s5pv210/gpiolib.c               |    1 +
>  arch/arm/plat-s5p/irq-gpioint.c               |  169
+++++++++++++++--------
> --
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h |   16 +++
>  7 files changed, 216 insertions(+), 73 deletions(-)
> 
> --

Ok, applied.
Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
