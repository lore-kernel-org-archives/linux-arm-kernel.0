From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 12 Mar 2011 12:23:45 +0900
Subject: [PATCH 0/5] S5PC210/S5PV310/EXYNOS4 interrupts update
In-Reply-To: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
References: <1297927527-1338-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <002c01cbe064$ea048fb0$be0daf10$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marek Szyprowski wrote:
> 
> Hello,
> 
> This patch series perform an update on interrupts support for
> S5PC210/S5PV310/EXYNOS4 platform. Two optional features have been added.
> The first one is GPIO interrupts handler, a second is support for board
> specific interrupts. The patches have been prepared to maximise the code
> reuse, so common code for gpio interrupts for s5pc100, s5pc110 & s5pc210
> have been prepared.
> 
> The patches have been prepared against
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> for-next branch (commit 857ddb87db).
> 
> Patches that make use of these 2 optional features for universal c210
> board will follow soon.
> 
> Best regards
> --
> Marek Szyprowski
> Samsung Poland R&D Center
> 
> 
> 
> Patch summary:
> 
> Marek Szyprowski (5):
>   ARM: S5PV310: Add missing GPYx banks.
>   ARM: Samsung: cleanup S5P gpio interrupt code
>   ARM: Samsung: add function to register gpio interrupt bank data
>   ARM: S5PC210: add support for gpio interrupts
>   ARM: S5PC210: add a placeholder for board specific interrupts
> 
>  arch/arm/mach-s5pc100/gpiolib.c               |    1 +
>  arch/arm/mach-s5pv210/gpiolib.c               |    1 +
>  arch/arm/mach-s5pv310/gpiolib.c               |   67 ++++++++++-
>  arch/arm/mach-s5pv310/include/mach/gpio.h     |   23 ++++-
>  arch/arm/mach-s5pv310/include/mach/irqs.h     |   16 ++-
>  arch/arm/plat-s5p/irq-gpioint.c               |  169
+++++++++++++++--------
> --
>  arch/arm/plat-samsung/include/plat/gpio-cfg.h |   16 +++
>  7 files changed, 220 insertions(+), 73 deletions(-)
> 
> --
> 1.7.1.569.g6f426

Marek,

Could you please re-send this based on my latest for-next which includes
Exynos4 changes?
And would be better to be separate gpio interrupt and board specific
interrupt.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
