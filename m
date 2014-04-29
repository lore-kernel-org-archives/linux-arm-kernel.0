From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 29 Apr 2014 10:27:23 +0100
Subject: [RESUBMIT RFC PATCH v2 3/3] drivers: mfd: Add support for Exynos
 PMU driver
In-Reply-To: <535F5AA7.2050001@samsung.com>
References: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
 <1398687607-4554-4-git-send-email-pankaj.dubey@samsung.com>
 <20140428122646.GF21279@lee--X1> <535F5AA7.2050001@samsung.com>
Message-ID: <20140429092723.GG29462@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>This patch moves Exynos PMU driver implementation from
> >>"arm/mach-exynos" to "drivers/mfd".
> >>This driver is mainly used for setting misc bits of register from PMU IP
> >>of Exynos SoC which will be required to configure before Suspend/Resume.
> >>Currently all these settings are done in "arch/arm/mach-exynos/pmu.c" but
> >>moving ahead for ARM64 based SoC support, there is a need of DT based
> >>implementation of PMU driver.
> >>This driver uses already existing DT binding information.
> >>
> >>CC: Sangbeom Kim <sbkim73@samsung.com>
> >>CC: Samuel Ortiz <sameo@linux.intel.com>
> >>CC: Lee Jones <lee.jones@linaro.org>
> >>Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> >>---
> >>  arch/arm/mach-exynos/Kconfig                           |    2 ++
> >>  arch/arm/mach-exynos/Makefile                          |    2 --
> >>  drivers/mfd/Kconfig                                    |    9 +++++++++
> >>  drivers/mfd/Makefile                                   |    1 +
> >>  arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c |    0
> >>  5 files changed, 12 insertions(+), 2 deletions(-)
> >>  rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)
> >So I just took a look at the code as zero changes looks suspicious to
> >me. The driver can not simply be copied and pasted into the MFD
> >subsystem in its current state.
> >
> >The fundamental question is; is this chip actually an MFD? What does
> >it do besides Power Management?
> 
> Exynos PMU chip controls different power states of Exynos, so mainly it
> does power management related stuff. Apart from this it has few registers
> which controls PHY of various IP blocks of Exynos such as USB, HDMI,
> ADC etc. But these phy controlling register are currently being accessed
> via "syscon" driver provided regmap APIs. For same the same reason
> Exynos PMU has second compatibility string as "syscon".

I suggest that this is not suitable for the MFD subsystem then.

Try drivers/power.


-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
