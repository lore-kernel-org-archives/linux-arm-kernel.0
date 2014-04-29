From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Tue, 29 Apr 2014 17:05:01 +0900
Subject: [RESUBMIT RFC PATCH v2 3/3] drivers: mfd: Add support for Exynos
 PMU driver
In-Reply-To: <20140428173743.GA14853@arm.com>
References: <1398687607-4554-1-git-send-email-pankaj.dubey@samsung.com>
 <1398687607-4554-4-git-send-email-pankaj.dubey@samsung.com>
 <20140428122646.GF21279@lee--X1> <20140428173743.GA14853@arm.com>
Message-ID: <535F5D2D.4000406@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/2014 02:37 AM, Catalin Marinas wrote:
> On Mon, Apr 28, 2014 at 01:26:46PM +0100, Lee Jones wrote:
>>> This patch moves Exynos PMU driver implementation from
>>> "arm/mach-exynos" to "drivers/mfd".
>>> This driver is mainly used for setting misc bits of register from PMU IP
>>> of Exynos SoC which will be required to configure before Suspend/Resume.
>>> Currently all these settings are done in "arch/arm/mach-exynos/pmu.c" but
>>> moving ahead for ARM64 based SoC support, there is a need of DT based
>>> implementation of PMU driver.
>>> This driver uses already existing DT binding information.
>>>
>>> CC: Sangbeom Kim <sbkim73@samsung.com>
>>> CC: Samuel Ortiz <sameo@linux.intel.com>
>>> CC: Lee Jones <lee.jones@linaro.org>
>>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>>> ---
>>>   arch/arm/mach-exynos/Kconfig                           |    2 ++
>>>   arch/arm/mach-exynos/Makefile                          |    2 --
>>>   drivers/mfd/Kconfig                                    |    9 +++++++++
>>>   drivers/mfd/Makefile                                   |    1 +
>>>   arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c |    0
>>>   5 files changed, 12 insertions(+), 2 deletions(-)
>>>   rename arch/arm/mach-exynos/pmu.c => drivers/mfd/exynos-pmu.c (100%)
>> So I just took a look at the code as zero changes looks suspicious to
>> me. The driver can not simply be copied and pasted into the MFD
>> subsystem in its current state.
>>
>> The fundamental question is; is this chip actually an MFD? What does
>> it do besides Power Management?
> I looked at the code briefly as well and I don't think it matches the
> mfd idea. Maybe it could be merged together with
> arch/arm/mach-exynos/pm.c and moved to drivers/power/ or a more
> appropriate directory for platform_suspend_ops.

Well I was also not quite sure about if "drivers/mfd" is proper place
for Exynos PMU, so I posted this patch as RFC.

If it does not seems matching with "drivers/mfd" idea, will it be suitable
for "drivers/power/" or should I go for something like "drivers/soc/samsung"?

Regarding your second point about merging this code with "mach-exynos/pm.c"
We have plan for this but, I would like to get it done via a separate patch 
series
as "mach-exynos/pm.c" has a lot of dependencies and requires significant
modifications. So this work can be treated as a first step towards that 
direction.

-- 
Best Regards,
Pankaj Dubey
