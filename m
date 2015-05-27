From: tomasz.nowicki@linaro.org (Tomasz Nowicki)
Date: Wed, 27 May 2015 10:06:26 +0200
Subject: [PATCH 05/11] x86, pci, acpi: Move arch-agnostic MMCONFIG (aka
 ECAM) and ACPI code out of arch/x86/ directory
In-Reply-To: <20150526170817.GU1565@arm.com>
References: <1432644564-24746-1-git-send-email-hanjun.guo@linaro.org>
 <1432644564-24746-6-git-send-email-hanjun.guo@linaro.org>
 <20150526170817.GU1565@arm.com>
Message-ID: <55657B02.5090805@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26.05.2015 19:08, Will Deacon wrote:
> On Tue, May 26, 2015 at 01:49:18PM +0100, Hanjun Guo wrote:
>> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>>
>> ECAM standard and MCFG table are architecture independent and it makes
>> sense to share common code across all architectures. Both are going to
>> corresponding files - ecam.c and mcfg.c
>>
>> While we are here, rename pci_parse_mcfg to acpi_parse_mcfg.
>> We already have acpi_parse_mcfg prototype which is used nowhere.
>> At the same time, we need pci_parse_mcfg been global so acpi_parse_mcfg
>> can be used perfectly here.
>>
>> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> Tested-by: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
>> ---
>>   arch/x86/Kconfig               |   3 +
>>   arch/x86/include/asm/pci_x86.h |  33 ------
>>   arch/x86/pci/acpi.c            |   1 +
>>   arch/x86/pci/mmconfig-shared.c | 244 +---------------------------------------
>>   arch/x86/pci/mmconfig_32.c     |   1 +
>>   arch/x86/pci/mmconfig_64.c     |   1 +
>>   arch/x86/pci/numachip.c        |   1 +
>>   drivers/acpi/Makefile          |   1 +
>>   drivers/acpi/mcfg.c            |  57 ++++++++++
>>   drivers/pci/Kconfig            |   7 ++
>>   drivers/pci/Makefile           |   5 +
>>   drivers/pci/ecam.c             | 245 +++++++++++++++++++++++++++++++++++++++++
>
> Why can't we make use of the ECAM implementation used by pci-host-generic
> and drivers/pci/access.c?

We had that question when I had posted MMCFG patch set separately, 
please see:
https://lkml.org/lkml/2015/3/11/492

Tomasz
