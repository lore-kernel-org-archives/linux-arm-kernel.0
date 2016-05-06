From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Fri, 06 May 2016 08:15:03 +0200
Subject: [RFC v2 02/13] power/mmc: Move pwrseq drivers to power/pwrseq
In-Reply-To: <4532bfb4-38f9-a61d-1d80-e5af18cd3d98@osg.samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
 <1462451666-17945-3-git-send-email-k.kozlowski@samsung.com>
 <4532bfb4-38f9-a61d-1d80-e5af18cd3d98@osg.samsung.com>
Message-ID: <572C3667.3090002@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/05/2016 08:44 PM, Javier Martinez Canillas wrote:
> Hello Krzysztof,
> 
> On 05/05/2016 08:34 AM, Krzysztof Kozlowski wrote:
>> The MMC power sequence drivers are useful also outside of MMC world: for
>> USB devices needed a hard-reset before probing. Before extending and
>> re-using pwrseq drivers, move them to a new place.
>>
>> The commit does not introduce significant changes in the pwrseq drivers
>> code so still all the functions are prefixed with "mmc_pwrseq". However
>> the MMC-specific pwrseq functions has to be now exported and everything
>> is hidden not by CONFIG_OF but by new CONFIG_POWER_SEQ option.
>>
>> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>> ---
> 
> [snip]
> 
>> --- a/drivers/mmc/core/Kconfig
>> +++ b/drivers/power/pwrseq/Kconfig
>> @@ -1,7 +1,12 @@
>> -#
>> -# MMC core configuration
>> -#
>> -config PWRSEQ_EMMC
>> +menuconfig POWER_SEQ
>> +	default y if OF
>> +	bool "Hardware reset support for specific devices"
>> +	help
>> +	  Provides drivers which reset the specific device before...
>> +
> 
> I think this text could be improved a little bit, maybe something like:
> 
> "Provides drivers that implements specific power sequences for chips,
> using the generic power sequence management interface".
> 
> The rest looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Yes, I wanted to code, not to focus on descriptions, so also commit
messages should be extended.

I'll fix this in next iteration.

BR,
Krzysztof
