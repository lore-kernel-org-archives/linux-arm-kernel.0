From: jdzheng@broadcom.com (Jiandong Zheng)
Date: Tue, 23 Aug 2011 09:59:54 -0700
Subject: [PATCH 1/2] arm: mach-bcmring: fix build error in core.c
In-Reply-To: <20110823164514.GG3895@n2100.arm.linux.org.uk>
References: <20110823111824.GA2806@maxin> <4E53D84F.5060604@broadcom.com>
	<20110823164514.GG3895@n2100.arm.linux.org.uk>
Message-ID: <4E53DC8A.3000701@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/23/2011 9:45 AM, Russell King - ARM Linux wrote:
> On Tue, Aug 23, 2011 at 09:41:51AM -0700, Jiandong Zheng wrote:
>> On 8/23/2011 4:18 AM, Maxin B. John wrote:
>>> CC      arch/arm/mach-bcmring/core.o
>>> arch/arm/mach-bcmring/core.c: In function 'bcmring_init_timer':
>>> arch/arm/mach-bcmring/core.c:238: error: implicit declaration of
>>> function 'sp804_clockevents_register'
>>> make[1]: *** [arch/arm/mach-bcmring/core.o] Error 1
>>> make: *** [arch/arm/mach-bcmring] Error 2
>>>
>>> Please let me know your comments on this fix:
>>>
>>> Signed-off-by: Maxin B. John<maxin.john@gmail.com>
>>> ---
>>> diff --git a/arch/arm/mach-bcmring/core.c b/arch/arm/mach-bcmring/core.c
>>> index 43eadbc..430da12 100644
>>> --- a/arch/arm/mach-bcmring/core.c
>>> +++ b/arch/arm/mach-bcmring/core.c
>>> @@ -235,7 +235,7 @@ void __init bcmring_init_timer(void)
>>>    	 */
>>>    	bcmring_clocksource_init();
>>>
>>> -	sp804_clockevents_register(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
>>> +	sp804_clockevents_init(TIMER0_VA_BASE, IRQ_TIMER0, "timer0");
>>>    }
>>>
>>>    struct sys_timer bcmring_timer = {
>>>
>> Signed-off-by: Jiandong Zheng<jdzheng@broadcom.com>
>
> Don't you mean acked-by or reviewed-by?
I meant I created the same patch and have tested it. But if acked-by or 
reviewed-by is less confusing, I am OK with it.

>
>> The same changes was in my comments on May 17 to Russell's serial
>> patches to convert to sp804 clk dev, but seems it got lost.
>
> Unfortunately... sorry about that.
>
To avoid this, should I submit every patch to patch system after 
reviewed through maillist?
