From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 4 Nov 2014 08:24:02 +0000
Subject: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU driver
In-Reply-To: <002601cff7de$0f8db7e0$2ea927a0$@samsung.com>
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-3-git-send-email-amit.daniel@samsung.com>
 <20141103152604.GA10544@x1>
 <002601cff7de$0f8db7e0$2ea927a0$@samsung.com>
Message-ID: <20141104082402.GE17577@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 04 Nov 2014, Pankaj Dubey wrote:
> On Monday, November 03, 2014 8:56 PM, Lee Jones wrote,
> > Subject: Re: [PATCH 02/12] drivers: mfd: Add support for Exynos PMU driver
> > 
> > On Mon, 03 Nov 2014, Amit Daniel Kachhap wrote:
> > 
> > > From: Pankaj Dubey <pankaj.dubey@samsung.com>
> > >
> > > This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
> > > to "drivers/mfd". This driver is mainly used for setting misc bits of
> > > register from PMU IP of Exynos SoC which will be required to configure
> > > before Suspend/Resume. Currently all these settings are done in
> > > "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
> > > support, there is a need of DT based implementation of PMU driver.
> > >
> > > This driver uses already existing DT binding information.
> > >
> > > CC: Sangbeom Kim <sbkim73@samsung.com>
> > > CC: Samuel Ortiz <sameo@linux.intel.com>
> > > CC: Lee Jones <lee.jones@linaro.org>
> > > Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> > > Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> > > ---
> > >  arch/arm/mach-exynos/Kconfig                       |    1 +
> > >  arch/arm/mach-exynos/Makefile                      |    2 +-
> > >  drivers/mfd/Kconfig                                |    9 +++++++++
> > >  drivers/mfd/Makefile                               |    1 +
> > >  .../mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c  |    0
> > >  5 files changed, 12 insertions(+), 1 deletion(-)  rename
> > > arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)
> > 
> > I thought we spoke about this already [1]?  What's changed?
> > 
> > [1] https://lkml.org/lkml/2014/4/29/193
> > 
> 
> Yes correct, we had discussion about this in above post. But at that time I was not having enough points to
> put forward for keeping Exynos PMU driver in MFD folder.

There are no valid points for keeping PMU code in MFD.

> At that point there was only one idea behind keeping Exynos PMU that in future it will be reused for ARM64
> based SoC for PM related functionalities.
> But in this series we have implemented Exynos Power Domain for Samsung's ARM64 based SoCs.
> 
> As far as I can see this will in following ways -
> 
> 1: Moving out PM domain specific code from mach-exynos and reuse of same code for ARM64 based SoC also.
> 2: Since PM domain relies on PMU registers and does not have its own DT binding, MFD client and MFD device
> is most suitable for making this kind of platform drivers.

MFD can be used to register the device, but the driver must not live
in MFD.  Please relocate it into drivers/power.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
