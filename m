From: amit.daniel@samsung.com (amit daniel kachhap)
Date: Mon, 1 Dec 2014 09:53:16 +0530
Subject: [PATCH v5 2/6] drivers: soc: Add support for Exynos PMU driver
In-Reply-To: <029c01d00c2b$aaeab560$00c02020$@kernel.org>
References: <1417270508-11174-1-git-send-email-amit.daniel@samsung.com>
 <1417270508-11174-3-git-send-email-amit.daniel@samsung.com>
 <029c01d00c2b$aaeab560$00c02020$@kernel.org>
Message-ID: <CADGdYn4yHfafuPOTvK1bDZ30F9U_w5NLYC0n1qRbB7s-9dTtzw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 30, 2014 at 4:54 AM, Kukjin Kim <kgene@kernel.org> wrote:
> Amit Daniel Kachhap wrote:
>>
>> This patch moves Exynos PMU driver implementation from "arm/mach-exynos"
>> to "drivers/soc/samsung". This driver is mainly used for setting misc
>> bits of register from PMU IP of Exynos SoC which will be required to
>> configure before Suspend/Resume. Currently all these settings are done
>> in "arch/arm/mach-exynos/pmu.c" but moving ahead for ARM64 based SoC
>> support, there is a need of this PMU driver in driver/* folder.
>>
>> This driver uses existing DT binding information and there should
>> be no functionality change in the supported platforms.
>>
>> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
>> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
>> ---
>>  arch/arm/mach-exynos/Makefile                      |    2 +-
>>  drivers/soc/Kconfig                                |    1 +
>>  drivers/soc/Makefile                               |    1 +
>>  drivers/soc/samsung/Kconfig                        |   20 ++++++++++++++++++++
>>  drivers/soc/samsung/Makefile                       |    1 +
>>  .../pmu.c => drivers/soc/samsung/exynos-pmu.c      |    0
>>  6 files changed, 24 insertions(+), 1 deletion(-)
>>  create mode 100644 drivers/soc/samsung/Kconfig
>>  create mode 100644 drivers/soc/samsung/Makefile
>>  rename arch/arm/mach-exynos/pmu.c => drivers/soc/samsung/exynos-pmu.c (100%)
>>
>> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
>> index bcefb54..b91b382 100644
>> --- a/arch/arm/mach-exynos/Makefile
>> +++ b/arch/arm/mach-exynos/Makefile
>> @@ -9,7 +9,7 @@ ccflags-$(CONFIG_ARCH_MULTIPLATFORM) += -I$(srctree)/$(src)/include -I$(srctree)
>>
>>  # Core
>>
>> -obj-$(CONFIG_ARCH_EXYNOS)    += exynos.o pmu.o exynos-smc.o firmware.o
>> +obj-$(CONFIG_ARCH_EXYNOS)    += exynos.o exynos-smc.o firmware.o
>>
>>  obj-$(CONFIG_EXYNOS_CPU_SUSPEND) += pm.o sleep.o
>>  obj-$(CONFIG_PM_SLEEP)               += suspend.o
>> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
>> index 76d6bd4..90f33b9 100644
>> --- a/drivers/soc/Kconfig
>> +++ b/drivers/soc/Kconfig
>> @@ -3,5 +3,6 @@ menu "SOC (System On Chip) specific Drivers"
>>  source "drivers/soc/qcom/Kconfig"
>>  source "drivers/soc/ti/Kconfig"
>>  source "drivers/soc/versatile/Kconfig"
>> +source "drivers/soc/samsung/Kconfig"
>
> Alphabetical order?
Ok, will add in the next version.
>
> [...]
>
> - Kukjin
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
