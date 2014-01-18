From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sat, 18 Jan 2014 12:05:24 +0800
Subject: [PATCH 04/20] ARM64 / ACPI: Introduce arm_core.c and its related
 head file
In-Reply-To: <20140117141241.GH16003@mudshark.cambridge.arm.com>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
 <20140117141241.GH16003@mudshark.cambridge.arm.com>
Message-ID: <52D9FD84.9090808@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-1-17 22:12, Will Deacon wrote:
> On Fri, Jan 17, 2014 at 12:24:58PM +0000, Hanjun Guo wrote:
>> Introduce arm_core.c and its related head file, after this patch,
>> we can get ACPI tables from firmware on ARM64 now.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> [...]
> 
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index bd9bbd0..2210353 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -41,6 +41,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/acpi.h>
>>  
>>  #include <asm/cputype.h>
>>  #include <asm/elf.h>
>> @@ -225,6 +226,11 @@ void __init setup_arch(char **cmdline_p)
>>  
>>  	arm64_memblock_init();
>>  
>> +	/* Parse the ACPI tables for possible boot-time configuration */
>> +	acpi_boot_table_init();
>> +	early_acpi_boot_init();
>> +	acpi_boot_init();
> 
> Do we really need *three* back-to-back calls for ACPI to initialise?

Sorry, my colleague Graeme had integrate them as one function but I
forgot to merge them in this patch, my bad, will update it in next
version.

Thanks
Hanjun
