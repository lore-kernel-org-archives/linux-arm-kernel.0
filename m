From: balbi@ti.com (Felipe Balbi)
Date: Tue, 6 Oct 2015 14:15:43 -0500
Subject: [PATCH 04/11] arm: omap2: timer: provide generic
 sync32k_timer_init function
In-Reply-To: <561413F2.4000700@ti.com>
References: <1444150927-14771-1-git-send-email-balbi@ti.com>
 <1444150927-14771-5-git-send-email-balbi@ti.com> <561413F2.4000700@ti.com>
Message-ID: <87r3l724gw.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Suman Anna <s-anna@ti.com> writes:
>> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
>> index 976ff9fa3594..d14e25b2d7a4 100644
>> --- a/arch/arm/mach-omap2/timer.c
>> +++ b/arch/arm/mach-omap2/timer.c
>> @@ -608,21 +608,13 @@ static void __init __omap_sync32k_timer_init(int clkev_nr, const char *clkev_src
>>  		omap2_sync32k_clocksource_init();
>>  }
>>  
>> -#ifdef CONFIG_ARCH_OMAP2
>> -void __init omap2_sync32k_timer_init(void)
>> +void __init omap_sync32k_timer_init(void)
>>  {
>>  	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
>>  			2, "timer_sys_ck", NULL, false);
>>  }
>> -#endif /* CONFIG_ARCH_OMAP2 */
>>  
>>  #if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_SOC_AM43XX)
>> -void __init omap3_sync32k_timer_init(void)
>> -{
>> -	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
>> -			2, "timer_sys_ck", NULL, false);
>> -}
>> -
>>  void __init omap3_secure_sync32k_timer_init(void)
>>  {
>>  	__omap_sync32k_timer_init(12, "secure_32k_fck", "ti,timer-secure",
>> @@ -640,15 +632,9 @@ void __init omap3_gptimer_timer_init(void)
>>  
>>  #if defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5) || \
>>  	defined(CONFIG_SOC_DRA7XX) || defined(CONFIG_SOC_AM43XX)
>> -static void __init omap4_sync32k_timer_init(void)
>> -{
>> -	__omap_sync32k_timer_init(1, "timer_32k_ck", "ti,timer-alwon",
>> -			2, "sys_clkin_ck", NULL, false);
>> -}
>> -
>>  void __init omap4_local_timer_init(void)
>>  {
>> -	omap4_sync32k_timer_init();
>> +	omap_sync32k_timer_init();
>
> Hmm, this is changing the parent clock source for the timer from
> sys_clkin_ck to timer_sys_ck for OMAP4 and OMAP5 below. I am not sure of
> the history behind the parent source, but is this what you intended to
> do here.

good catch. I'll fix this for next revision

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151006/72472cd5/attachment.sig>
