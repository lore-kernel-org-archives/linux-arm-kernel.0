From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Thu, 26 Mar 2015 10:54:46 +0100
Subject: [PATCH 06/13] ARM: at91: PIT: make IO endian agnostic
In-Reply-To: <550FF8B3.2080708@atmel.com>
References: <1426693992-31163-1-git-send-email-ben.dooks@codethink.co.uk>
 <1426693992-31163-7-git-send-email-ben.dooks@codethink.co.uk>
 <550FF8B3.2080708@atmel.com>
Message-ID: <5513D766.8020908@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/23/2015 12:27 PM, Nicolas Ferre wrote:
> Le 18/03/2015 16:53, Ben Dooks a ?crit :
>> Fix the use of __raw IO accessor with the readl/writel_relaxed versions
>> to allow the code to be used on a system running in big endian.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
>> --
>> CC: Daniel Lezcano <daniel.lezcano@linaro.org>
>> CC: Thomas Gleixner <tglx@linutronix.de>
>> CC: Linux Kernel <linux-kernel@vger.kernel.org>
>> CC: Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>
>> CC: Andrew Victor <linux@maxim.org.za>
>> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Yes:
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>
> Daniel, do you want to take it?

Yep.

>> CC: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> ---
>>   drivers/clocksource/timer-atmel-pit.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
>> index b5b4d45..c0304ff 100644
>> --- a/drivers/clocksource/timer-atmel-pit.c
>> +++ b/drivers/clocksource/timer-atmel-pit.c
>> @@ -61,12 +61,12 @@ static inline struct pit_data *clkevt_to_pit_data(struct clock_event_device *clk
>>
>>   static inline unsigned int pit_read(void __iomem *base, unsigned int reg_offset)
>>   {
>> -	return __raw_readl(base + reg_offset);
>> +	return readl_relaxed(base + reg_offset);
>>   }
>>
>>   static inline void pit_write(void __iomem *base, unsigned int reg_offset, unsigned long value)
>>   {
>> -	__raw_writel(value, base + reg_offset);
>> +	writel_relaxed(value, base + reg_offset);
>>   }
>>
>>   /*
>>
>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
