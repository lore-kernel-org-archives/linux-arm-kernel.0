From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 16 Sep 2014 16:30:20 -0700
Subject: [PATCH 2/2] ARM: vexpress: Remove non-DT code
In-Reply-To: <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
References: <1410359618-3441-1-git-send-email-pawel.moll@arm.com>
 <1410359618-3441-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20140916233020.GC30918@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Sep 2014, Pawel Moll wrote:

> Now, with the CLCD DT support available, there is no
> more reason to keep the non-DT support for V2P-CA9.
> 
> Removed, together with "some" supporting code. It was
> necessary to make PLAT_VERSATILE_SCHED_CLOCK optional
> and selected by the machines still interested in it.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  arch/arm/Kconfig                                  |   2 +
>  arch/arm/mach-vexpress/Kconfig                    |   3 -
>  arch/arm/mach-vexpress/Makefile                   |   3 +-
>  arch/arm/mach-vexpress/core.h                     |   7 -
>  arch/arm/mach-vexpress/ct-ca9x4.c                 | 212 ------------
>  arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |  47 ---
>  arch/arm/mach-vexpress/include/mach/hardware.h    |   1 -
>  arch/arm/mach-vexpress/include/mach/irqs.h        |   6 -
>  arch/arm/mach-vexpress/include/mach/motherboard.h |  88 -----
>  arch/arm/mach-vexpress/platsmp.c                  |  42 ---
>  arch/arm/mach-vexpress/v2m.c                      | 374 ----------------------
>  arch/arm/plat-versatile/Kconfig                   |   2 +-
>  drivers/clk/versatile/Makefile                    |   1 -
>  drivers/clk/versatile/clk-vexpress-osc.c          |   7 -
>  drivers/clk/versatile/clk-vexpress.c              |  86 -----
>  drivers/mfd/vexpress-sysreg.c                     |  71 +---
>  drivers/misc/vexpress-syscfg.c                    |  60 +---
>  drivers/power/reset/vexpress-poweroff.c           |  17 +-
>  include/linux/vexpress.h                          |  19 --
>  19 files changed, 35 insertions(+), 1013 deletions(-)
>  delete mode 100644 arch/arm/mach-vexpress/ct-ca9x4.c
>  delete mode 100644 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h
>  delete mode 100644 arch/arm/mach-vexpress/include/mach/hardware.h
>  delete mode 100644 arch/arm/mach-vexpress/include/mach/irqs.h
>  delete mode 100644 arch/arm/mach-vexpress/include/mach/motherboard.h
>  delete mode 100644 drivers/clk/versatile/clk-vexpress.c

Is it really necessary to take the one-big-patch approach?  I'm sure
you can find a nicer way than to burden all these maintainers.
Naturally I can't speak for everyone concerned, but I don't really
want to be carrying all this if I don't have to.  Granted I'm not
carrying any patches touching drivers/mfd/vexpress-sysreg.c at the
moment, but equally I don't want to rule that out.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
