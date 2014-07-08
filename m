From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Tue, 08 Jul 2014 17:23:16 +0800
Subject: [PATCH 4/4] ACPI: Make EC debugfs depend on X86 || IA64 in Kconfig
In-Reply-To: <200683000.sgUJl2AyWR@vostro.rjw.lan>
References: <1404290847-7671-1-git-send-email-hanjun.guo@linaro.org>
 <1404290847-7671-5-git-send-email-hanjun.guo@linaro.org>
 <200683000.sgUJl2AyWR@vostro.rjw.lan>
Message-ID: <53BBB884.5000005@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014?07?08? 05:16, Rafael J. Wysocki wrote:
> On Wednesday, July 02, 2014 04:47:26 PM Hanjun Guo wrote:
>> Since EC (Embedded controller) needs SCI for the interupt which
>> is not available on ARM64, make the EC debugfs depend on X86 || IA64
>> only in the Kconfig file.
>>
>> Reviewed-by: Grant Likely <grant.likely@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index 0e6f72d..7de5e3f 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -69,6 +69,7 @@ config ACPI_PROCFS_POWER
>>  
>>  config ACPI_EC_DEBUGFS
>>  	tristate "EC read/write access through /sys/kernel/debug/ec"
>> +	depends on X86 || IA64
> This is totally inconsistent with the other patches in the series where you
> define per-arch symbols for similar things.  In addition to that, do we need
> to build ec.c on ARM at all?

Yes, EC will be needed on ARM. This patch is not needed after some more
consideration, I will drop it.

Thanks
Hanjun
