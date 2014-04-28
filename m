From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 28 Apr 2014 21:08:21 +0900
Subject: [RFC PATCH v2 3/3] drivers: mfd: Add support for Exynos PMU driver
In-Reply-To: <20140428112153.GT21279@lee--X1>
References: <1396427085-4696-1-git-send-email-pankaj.dubey@samsung.com>
 <1398431131-5946-1-git-send-email-pankaj.dubey@samsung.com>
 <1398431131-5946-4-git-send-email-pankaj.dubey@samsung.com>
 <20140428112153.GT21279@lee--X1>
Message-ID: <535E44B5.7030202@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 08:21 PM, Lee Jones wrote:
> On Fri, 25 Apr 2014, Pankaj Dubey wrote:
>
>> This patch moves Exynos PMU driver implementation from
>> "arm/mach-exynos" to "drivers/mfd".
>> This driver is mainly used for setting misc bits of register from PMU IP
>> of Exynos SoC which will be required to configure before Suspend/Resume.
>> Currently all these settings are done in "arch/arm/mach-exynos/pmu.c" but
>> moving ahead for ARM64 based SoC support, there is a need of DT based
>> implementation of PMU driver.
>> This driver uses already existing DT binding information.
>>
>> CC: Sangbeom Kim <sbkim73@samsung.com>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> CC: Lee Jones <lee.jones@linaro.org>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> ---
>>   arch/arm/mach-exynos/Kconfig  |    2 +
>>   arch/arm/mach-exynos/Makefile |    2 -
>>   arch/arm/mach-exynos/pmu.c    |  521 -----------------------------------------
>>   drivers/mfd/Kconfig           |    9 +
>>   drivers/mfd/Makefile          |    1 +
>>   drivers/mfd/exynos-pmu.c      |  521 +++++++++++++++++++++++++++++++++++++++++
>>   6 files changed, 533 insertions(+), 523 deletions(-)
>>   delete mode 100644 arch/arm/mach-exynos/pmu.c
>>   create mode 100644 drivers/mfd/exynos-pmu.c
> Same with this patch, `git format-patch -M`.

OK, I will resubmit this series.



-- 
Best Regards,
Pankaj Dubey
