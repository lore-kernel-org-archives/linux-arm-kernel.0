From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Wed, 27 May 2015 15:31:51 +0800
Subject: [PATCH 11/11] ARM64 / PCI / ACPI: support for ACPI based PCI
 hostbridge init
In-Reply-To: <55648D52.4000809@linaro.org>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-12-git-send-email-hanjun.guo@linaro.org>
 <55648D52.4000809@linaro.org>
Message-ID: <556572E7.1090802@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015?05?26? 23:12, Tomasz Nowicki wrote:
> On 26.05.2015 14:49, Hanjun Guo wrote:
>> Based on Jiang Liu's common interface to support PCI host bridge
>> init and refactoring of MMCONFIG, this patch using information
>> from ACPI MCFG table and IO/irq resources from _CRS to init
>> ARM64 PCI hostbridge, then PCI will work on ARM64.
>>
>> This patch is based on Mark Salter and Tomasz Nowicki's work.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> CC: Arnd Bergmann <arnd@arndb.de>
>> CC: Catalin Marinas <catalin.marinas@arm.com>
>> CC: Liviu Dudau <Liviu.Dudau@arm.com>
>> CC: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
>> CC: Will Deacon <will.deacon@arm.com>
>> ---
>>   arch/arm64/Kconfig      |   7 ++
>>   arch/arm64/kernel/pci.c | 245
>> +++++++++++++++++++++++++++++++++++++++++++++---
>>   drivers/pci/pci.c       |  26 +++--
>>   3 files changed, 257 insertions(+), 21 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 9b80428..8e4b789 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -276,6 +276,13 @@ config PCI_DOMAINS_GENERIC
>>   config PCI_SYSCALL
>>       def_bool PCI
>>
>> +config PCI_MMCONFIG
>> +    def_bool y
>> +    select PCI_ECAM
>> +    select HAVE_PCI_ECAM
>> +    select GENERIC_PCI_ECAM
> HAVE_PCI_ECAM and GENERIC_PCI_ECAM should be selected by platform.

OK.

>
>> +    depends on ACPI
> I think we should depend on PCI too.

Since ACPI depends on PCI, denpends on
PCI is duplicate I think.

Thanks
Hanjun
