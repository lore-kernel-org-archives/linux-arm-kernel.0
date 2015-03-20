From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 20 Mar 2015 11:58:00 +0100
Subject: [PATCH v2] clocksource: atmel-st: select MFD_SYSCON
In-Reply-To: <550ACE6A.4000705@linaro.org>
References: <1426771068-9657-1-git-send-email-alexandre.belloni@free-electrons.com>
 <550ACE6A.4000705@linaro.org>
Message-ID: <550BFD38.6080008@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 19/03/2015 14:26, Daniel Lezcano a ?crit :
> On 03/19/2015 02:17 PM, Alexandre Belloni wrote:
>> Enforce MFD_SYSCON selection as the driver needs it. Else, it will still
>> compile with some warning about X1, x2 or sr being used uninitialized.
>>
>> Reported-by: fengguang.wu at intel.com
>> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
>> ---
>> Daniel,
>>
>> I think this should go through the at91 tree as the patch introducing that issue
>> went there.
> 
> Ok.
> 
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I take it: thanks!

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>


>>   drivers/clocksource/Kconfig | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
>> index 168035883afa..55aef6f89074 100644
>> --- a/drivers/clocksource/Kconfig
>> +++ b/drivers/clocksource/Kconfig
>> @@ -146,6 +146,7 @@ config ATMEL_PIT
>>   config ATMEL_ST
>>   	bool
>>   	select CLKSRC_OF
>> +	select MFD_SYSCON
>>
>>   config CLKSRC_METAG_GENERIC
>>   	def_bool y if METAG
>>
> 
> 


-- 
Nicolas Ferre
