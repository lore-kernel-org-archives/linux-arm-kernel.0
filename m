From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 11 Dec 2013 15:00:17 +0100
Subject: [PATCH 6/6] clocksource: dw_apb_timer_of: Fix support for dts
 binding "snps, dw-apb-timer"
In-Reply-To: <20131211050012.GB1217@tarshish>
References: <52A767CB.3010501@linaro.org>
 <1386702972-25565-1-git-send-email-daniel.lezcano@linaro.org>
 <1386702972-25565-6-git-send-email-daniel.lezcano@linaro.org>
 <20131211050012.GB1217@tarshish>
Message-ID: <52A86FF1.40508@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/11/2013 06:00 AM, Baruch Siach wrote:
> Hi Daniel, Dinh,
>
> On Tue, Dec 10, 2013 at 08:16:12PM +0100, Daniel Lezcano wrote:
>> From: Dinh Nguyen <dinguyen@altera.com>
>>
>> In commit 620f5e1cbf (dts: Rename DW APB timer compatible strings), both
>> "snps,dw-apb-timer-sp" and "snps,dw-apb-timer-osc" were deprecated in place
>> of "snps,dw-apb-timer". But the driver also needs to be udpated in order to
>> support this new binding "snps,dw-apb-timer".
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>
> I guess this (and the previous one) should also be pushed to v3.12-stable,
> isn't it?

Mmh, yes.

Thomas,

will you send those patches to Greg-KH ? Otherwise I am willing to 
create a -stable branch for each release to put those in and send them 
to stable@ directly.

Thanks
   -- Daniel


>>   drivers/clocksource/dw_apb_timer_of.c |    5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clocksource/dw_apb_timer_of.c b/drivers/clocksource/dw_apb_timer_of.c
>> index b29d7cd..2a2ea27 100644
>> --- a/drivers/clocksource/dw_apb_timer_of.c
>> +++ b/drivers/clocksource/dw_apb_timer_of.c
>> @@ -113,7 +113,6 @@ static u64 read_sched_clock(void)
>>
>>   static const struct of_device_id sptimer_ids[] __initconst = {
>>   	{ .compatible = "picochip,pc3x2-rtc" },
>> -	{ .compatible = "snps,dw-apb-timer-sp" },
>>   	{ /* Sentinel */ },
>>   };
>>
>> @@ -151,4 +150,6 @@ static void __init dw_apb_timer_init(struct device_node *timer)
>>   	num_called++;
>>   }
>>   CLOCKSOURCE_OF_DECLARE(pc3x2_timer, "picochip,pc3x2-timer", dw_apb_timer_init);
>> -CLOCKSOURCE_OF_DECLARE(apb_timer, "snps,dw-apb-timer-osc", dw_apb_timer_init);
>> +CLOCKSOURCE_OF_DECLARE(apb_timer_osc, "snps,dw-apb-timer-osc", dw_apb_timer_init);
>> +CLOCKSOURCE_OF_DECLARE(apb_timer_sp, "snps,dw-apb-timer-sp", dw_apb_timer_init);
>> +CLOCKSOURCE_OF_DECLARE(apb_timer, "snps,dw-apb-timer", dw_apb_timer_init);
>> --
>> 1.7.9.5
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
