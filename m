From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 31 Jan 2013 10:30:44 +0000
Subject: [PATCH v2 0/4] Preparatory GIC patches for arm64 support
In-Reply-To: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
References: <1359476319-23720-1-git-send-email-catalin.marinas@arm.com>
Message-ID: <20130131103044.GB12877@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Olof, Arnd,

On Tue, Jan 29, 2013 at 04:18:35PM +0000, Catalin Marinas wrote:
> That's the second version of the GIC clean-up patches to support arm64.
> The only change from v1 is that the second patch (chained_irq.h) also
> covers drivers/gpio and drivers/pinctrl (#include change).

Are you ok to merge this series via the arm-soc tree for 3.9-rc1? There
are no complaints so far (only acks ;). This would allow me to push GIC
support for arm64.

Thanks,

Catalin


Stats below for reference:

> Catalin Marinas (4):
>   arm: Move the set_handle_irq and handle_arch_irq declarations to
>     asm/irq.h
>   arm: Move chained_irq_(enter|exit) to a generic file
>   irqchip: gic: Call handle_bad_irq() directly
>   irqchip: gic: Perform the gic_secondary_init() call via CPU notifier
> 
>  arch/arm/include/asm/irq.h                  |  5 +++
>  arch/arm/include/asm/mach/irq.h             | 36 --------------------
>  arch/arm/mach-at91/gpio.c                   |  3 +-
>  arch/arm/mach-exynos/common.c               |  1 +
>  arch/arm/mach-exynos/platsmp.c              |  8 -----
>  arch/arm/mach-highbank/platsmp.c            |  7 ----
>  arch/arm/mach-imx/platsmp.c                 | 12 -------
>  arch/arm/mach-msm/platsmp.c                 |  8 -----
>  arch/arm/mach-omap2/omap-smp.c              |  7 ----
>  arch/arm/mach-shmobile/smp-emev2.c          |  7 ----
>  arch/arm/mach-shmobile/smp-r8a7779.c        |  7 ----
>  arch/arm/mach-shmobile/smp-sh73a0.c         |  7 ----
>  arch/arm/mach-socfpga/platsmp.c             | 12 -------
>  arch/arm/mach-spear13xx/platsmp.c           |  8 -----
>  arch/arm/mach-tegra/platsmp.c               |  8 -----
>  arch/arm/mach-ux500/platsmp.c               |  8 -----
>  arch/arm/plat-samsung/irq-vic-timer.c       |  3 +-
>  arch/arm/plat-samsung/s5p-irq-gpioint.c     |  3 +-
>  arch/arm/plat-versatile/platsmp.c           |  8 -----
>  drivers/gpio/gpio-msm-v2.c                  |  3 +-
>  drivers/gpio/gpio-mxc.c                     |  2 +-
>  drivers/gpio/gpio-omap.c                    |  3 +-
>  drivers/gpio/gpio-pl061.c                   |  2 +-
>  drivers/gpio/gpio-pxa.c                     |  3 +-
>  drivers/gpio/gpio-tegra.c                   |  3 +-
>  drivers/irqchip/irq-gic.c                   | 32 +++++++++++++-----
>  drivers/irqchip/irq-vic.c                   |  2 +-
>  drivers/pinctrl/pinctrl-at91.c              |  3 +-
>  drivers/pinctrl/pinctrl-exynos.c            |  3 +-
>  drivers/pinctrl/pinctrl-nomadik.c           |  2 +-
>  drivers/pinctrl/pinctrl-sirf.c              |  2 +-
>  drivers/pinctrl/spear/pinctrl-plgpio.c      |  2 +-
>  drivers/staging/imx-drm/ipu-v3/ipu-common.c |  2 +-
>  include/linux/irqchip/arm-gic.h             |  1 -
>  include/linux/irqchip/chained_irq.h         | 52 +++++++++++++++++++++++++++++
>  35 files changed, 97 insertions(+), 178 deletions(-)
>  create mode 100644 include/linux/irqchip/chained_irq.h
