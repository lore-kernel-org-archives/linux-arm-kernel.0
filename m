From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 3 Nov 2014 15:26:04 +0000
Subject: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU driver
In-Reply-To: <1414986790-11940-3-git-send-email-amit.daniel@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-3-git-send-email-amit.daniel@samsung.com>
Message-ID: <20141103152604.GA10544@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 03 Nov 2014, Amit Daniel Kachhap wrote:

> From: Pankaj Dubey <pankaj.dubey@samsung.com>
> 
> This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
> to "drivers/mfd". This driver is mainly used for setting misc bits of
> register from PMU IP of Exynos SoC which will be required to configure
> before Suspend/Resume. Currently all these settings are done in
> "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC support,
> there is a need of DT based implementation of PMU driver.
> 
> This driver uses already existing DT binding information.
> 
> CC: Sangbeom Kim <sbkim73@samsung.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> CC: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> ---
>  arch/arm/mach-exynos/Kconfig                       |    1 +
>  arch/arm/mach-exynos/Makefile                      |    2 +-
>  drivers/mfd/Kconfig                                |    9 +++++++++
>  drivers/mfd/Makefile                               |    1 +
>  .../mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c  |    0
>  5 files changed, 12 insertions(+), 1 deletion(-)
>  rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)

I thought we spoke about this already [1]?  What's changed?

[1] https://lkml.org/lkml/2014/4/29/193

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
