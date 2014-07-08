From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Jul 2014 17:55:38 +0800
Subject: [PATCH 1/4] ACPI: ARM64 does not have a BIOS add config for BIOS
 table scan.
In-Reply-To: <1430951.SWzYBgFe0M@vostro.rjw.lan>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org>
 <1404290847-7671-2-git-send-email-hanjun.guo@linaro.org>
 <1430951.SWzYBgFe0M@vostro.rjw.lan>
Message-ID: <53BBC01A.4030704@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?07?08? 05:06, Rafael J. Wysocki wrote:
> On Wednesday, July 02, 2014 04:47:23 PM Hanjun Guo wrote:
>> From: Graeme Gregory <graeme.gregory@linaro.org>
>>
>> With the addition of ARM64 that does not have a traditional BIOS to
>> scan, add a config option which is selected on x86 and ia64 to do
>> the traditional BIOS scanning for tables.
>>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  arch/ia64/Kconfig    |    1 +
>>  arch/x86/Kconfig     |    1 +
>>  drivers/acpi/Kconfig |    3 +++
>>  drivers/acpi/osl.c   |    4 +++-
>>  4 files changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/ia64/Kconfig b/arch/ia64/Kconfig
>> index 2f3abcf..f82b352 100644
>> --- a/arch/ia64/Kconfig
>> +++ b/arch/ia64/Kconfig
>> @@ -47,6 +47,7 @@ config IA64
>>  	select MODULES_USE_ELF_RELA
>>  	select ARCH_USE_CMPXCHG_LOCKREF
>>  	select HAVE_ARCH_AUDITSYSCALL
>> +	select ACPI_SCAN_BIOS_NOT_EFI
> I would call this ACPI_LEGACY_TABLES_LOOKUP or something like that.
>
> Also please do
>
> +	select ACPI_LEGACY_TABLES_LOOKUP if ACPI
>
> in analogy with patch [3/4] in this series.

OK, I will update this patch accordingly, thanks for the great config
name :)

Thanks
Hanjun
