From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 28 Apr 2014 13:18:53 +0100
Subject: [RESUBMIT RFC PATCH v2 3/3] drivers: mfd: Add support for Exynos
 PMU driver
In-Reply-To: <1398687607-4554-4-git-send-email-pankaj.dubey@samsung.com>
References: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
 <1398687607-4554-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <20140428121853.GE21279@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch moves Exynos PMU driver implementation from
> "arm/mach-exynos" to "drivers/mfd".
> This driver is mainly used for setting misc bits of register from PMU IP
> of Exynos SoC which will be required to configure before Suspend/Resume.
> Currently all these settings are done in "arch/arm/mach-exynos/pmu.c" but
> moving ahead for ARM64 based SoC support, there is a need of DT based
> implementation of PMU driver.
> This driver uses already existing DT binding information.
> 
> CC: Sangbeom Kim <sbkim73@samsung.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> CC: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                           |    2 ++
>  arch/arm/mach-exynos/Makefile                          |    2 --
>  drivers/mfd/Kconfig                                    |    9 +++++++++
>  drivers/mfd/Makefile                                   |    1 +
>  arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c |    0
>  5 files changed, 12 insertions(+), 2 deletions(-)
>  rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)

[...]

> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 3383412..fd48870 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -1203,6 +1203,15 @@ config MFD_STW481X
>  	  in various ST Microelectronics and ST-Ericsson embedded
>  	  Nomadik series.
>  
> +config MFD_EXYNOS_PMU
> +	tristate "Support Exynos Power Managment Unit"
> +	depends on ARM || ARM64
> +	help
> +	Exynos SoC have Power Management Unit (PMU) which controls power and
> +	operation state of Exynos SoC in two different ways. This driver
> +	provides impmentation of PMU driver and provides basic functionality
> +	required during these operation state.
> +

The help should be indented. Take a look at the other entries.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
