From: tushar.behera@linaro.org (Tushar Behera)
Date: Mon, 20 May 2013 15:05:37 +0530
Subject: [PATCH 0/6] Fix suspend/resume issues created by pinmux on exynos,
 part 2
In-Reply-To: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
References: <1368807872-2601-1-git-send-email-t.figa@samsung.com>
Message-ID: <5199EE69.7090605@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/17/2013 09:54 PM, Tomasz Figa wrote:
> This series aims at fixing problems with suspend/resume on Exynos SoCs
> introduced by migration of GPIO and EINT support to pin control driver
> on DT-enabled platforms.
> 
> The patches fix following issues:
>  - missing support for IRQ wake of pinctrl-exynos driver
>  - legacy GPIO and EINT save/restore handling in platform PM code
>    inappropriate on pinctrl-enabled platforms
>  - several EINT-related registers must be saved as well
>  
> The series is based on a patch by Doug Anderson that adds suspend/restore
> of pinctrl registers to pinctrl-samsung driver:
> [PATCH v3] pinctrl: samsung: fix suspend/resume functionality
> http://www.spinics.net/lists/kernel/msg1534119.html
> 
> On Exynos4210-based Trats board:
> Tested-by: Tomasz Figa <t.figa@samsung.com>
> 

On Exynos5250-based Arndale board:
Tested-by: Tushar Behera <tushar.behera@linaro.org>

> Tomasz Figa (6):
>   pinctrl: exynos: Add support for set_irq_wake of wake-up EINTs
>   ARM: EXYNOS: Fix EINT wake-up mask configuration when pinctrl is used
>   ARM: SAMSUNG: pm: Adjust for pinctrl- and DT-enabled platforms
>   pinctrl: samsung: Add support for SoC-specific suspend/resume
>     callbacks
>   pinctrl: samsung: Allow per-bank SoC-specific private data
>   pinctrl: exynos: Handle suspend/resume of GPIO EINT registers
> 
>  arch/arm/mach-exynos/include/mach/pm-core.h |  14 +++-
>  arch/arm/plat-samsung/pm.c                  |  17 +++--
>  drivers/pinctrl/pinctrl-exynos.c            | 106 ++++++++++++++++++++++++++++
>  drivers/pinctrl/pinctrl-exynos.h            |   1 +
>  drivers/pinctrl/pinctrl-samsung.c           |   6 ++
>  drivers/pinctrl/pinctrl-samsung.h           |   4 ++
>  6 files changed, 142 insertions(+), 6 deletions(-)
> 


-- 
Tushar Behera
