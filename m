From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 27 May 2014 10:18:36 +0100
Subject: [PATCH] ARM: vexpress: refine dependencies for new code
In-Reply-To: <6862654.ZzBrnrRESe@wuerfel>
References: <6862654.ZzBrnrRESe@wuerfel>
Message-ID: <20140527091836.GE5875@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> The versatile express changes for 3.16 introduced a number of
> build regressions for randconfig kernels by not tracking dependencies
> between the components right.
> 
> This patch tries to rectify that:
> 
> * the mach-vexpress code cannot link without the syscfg driver,
>   which in turn needs MFD_VEXPRESS_SYSREG
> * various drivers call devm_regmap_init_vexpress_config(), which
>   has to be exported so it can be used by loadable modules
> * the configuration bus uses OF DT helper functions that are not
>   available to platforms disable CONFIG_OF
> * The sysreg driver exports GPIOs through gpiolib, which can
>   be disabled on some platforms.
> * The clocksource code cannot be built on platforms that don't
>   use modern timekeeping but rely on gettimeoffset.

Where's the diff?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

[...]

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig

For the MFD part:

  Acked-by: Lee Jones <lee.jones@linaro.org>

This patch has a high chance of creating conflicts.  Can someone apply
this to a branch, tag it and sent out a pull-request to the other
maintainers please?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
