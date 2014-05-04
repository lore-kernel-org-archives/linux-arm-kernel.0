From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Sun, 04 May 2014 17:03:39 +0800
Subject: [PATCH v3 part1 11/11] ACPI: Make EC depend on X86 || IA64 in
 Kconfig
In-Reply-To: <20140429095638.D694AC4095B@trevor.secretlab.ca>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>	<1398432017-8506-12-git-send-email-hanjun.guo@linaro.org>
 <20140429095638.D694AC4095B@trevor.secretlab.ca>
Message-ID: <5366026B.1020008@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2014-4-29 17:56, Grant Likely wrote:
> On Fri, 25 Apr 2014 21:20:17 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
>> Since EC (Embedded controller) needs SCI for the interupt which
>> is not available on ARM64, make it depend on X86 || IA64 only
>> in the Kconfig file.
>>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
>> ---
>>  drivers/acpi/Kconfig |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index ae45088..391325c 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -49,6 +49,7 @@ config ACPI_SLEEP
>>  
>>  config ACPI_EC_DEBUGFS
>>  	tristate "EC read/write access through /sys/kernel/debug/ec"
>> +	depends on X86 || IA64
> 
> Nit: This patch and patch 10 should be applied before patch 9 which adds
> the option to enable ACPI, but otherwise this series looks reasonable to
> me and aside from the comments made by others is pretty much ready to be
> merged. Go ahead and add my reviewed-by tag to the whole series.
> 
> Reviewed-by: Grant Likely <grant.likely@linaro.org>

Great, we will address all the comments and send out another version.

Thanks
Hanjun
