From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 27 Nov 2013 09:26:21 +0800
Subject: [PATCH] rtc: pxa: drop usage of CLOCK_TICK_RATE
In-Reply-To: <20131126133731.GE28642@pengutronix.de>
References: <1383942318-12569-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20131126133731.GE28642@pengutronix.de>
Message-ID: <52954A3D.3040108@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/26/2013 09:37 PM, Uwe Kleine-K?nig wrote:
> Hello,
>
> [Cc: += akpm]
>
> On Fri, Nov 08, 2013 at 09:25:18PM +0100, Uwe Kleine-K?nig wrote:
>> The symbol CLOCK_TICK_RATE is (at least on ARM) defined in an platform
>> specific header <mach/timex.h>. There are plans to stop using and kill
>> these platform specific headers. So fix the only user of pxa's
>> <mach/timex.h> to not use it.
>>
>> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> Who is looking for this patch?
>
> Best regards
> Uwe
>
>> ---
>> It would be nice to use the clk API to find the tick rate, but I didn't
>> find any clk to use.
>> ---
>>   drivers/rtc/rtc-pxa.c |    2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-pxa.c b/drivers/rtc/rtc-pxa.c
>> index a355f2b..0ba07e1 100644
>> --- a/drivers/rtc/rtc-pxa.c
>> +++ b/drivers/rtc/rtc-pxa.c
>> @@ -32,7 +32,7 @@
>>
>>   #include <mach/hardware.h>
>>
>> -#define TIMER_FREQ		CLOCK_TICK_RATE
>> +#define TIMER_FREQ		get_clock_tick_rate()
>>   #define RTC_DEF_DIVIDER		(32768 - 1)
>>   #define RTC_DEF_TRIM		0
>>   #define MAXFREQ_PERIODIC	1000
>> --
>> 1.7.10.4
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>

Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>

I think that Alessandro could help to merge.

Alessandro,
Is it right?

Regards
Haojian
