From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Mon, 14 Oct 2013 16:01:36 +0200
Subject: [PATCH v2 11/12] cpuidle: mvebu: Add initial CPU idle support
 for Armada 370/XP SoC
In-Reply-To: <5235EEE1.8020501@linaro.org>
References: <1379066801-16276-1-git-send-email-gregory.clement@free-electrons.com>
 <1379066801-16276-12-git-send-email-gregory.clement@free-electrons.com>
 <52333112.2050003@linaro.org> <5235C587.4030802@free-electrons.com>
 <5235EEE1.8020501@linaro.org>
Message-ID: <525BF940.2010403@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/09/2013 19:31, Daniel Lezcano wrote:
Hi Daniel,

>>>> +	.state_count = ARMADA_370_XP_MAX_STATES,
>>>> +};
>>>
>>> What about the local timers ? Are they shutdown ?
>>
>> I need to chekc it.
> 
> Ok, if it is the case, there is the flag CPUIDLE_FLAG_TIMER_STOP to tell
> the cpuidle framework to switch to the broadcast timer with this state.

I have just sent a new version taking into account all your remarks, expect
this one. The timers used on Armada 370/XP are only the locale timer then
they are not shutdown when the CPUs go to idle.

Regards,

Gregory

> 
>>>> +static int __init armada_370_xp_cpuidle_init(void)
>>>> +{
>>>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,armada-370-xp-pmsu"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	if (!of_find_compatible_node(NULL, NULL, "marvell,coherency-fabric"))
>>>> +		return -ENODEV;
>>>> +
>>>> +	pr_info("Initializing Armada-XP CPU power management ");
>>>> +
>>>> +	armada_370_xp_pmsu_enable_l2_powerdown_onidle();
>>>> +
>>>> +	return cpuidle_register(&armada_370_xp_idle_driver, NULL);
>>>> +}
>>>> +
>>>> +module_init(armada_370_xp_cpuidle_init);
>>>
>>> Isn't it possible to replace it by module_platform_driver ? like ux500
>>> or kirkwood ?
>>
>> It should be possible indeed, I will check it.
> 
> That would be great. It is a nicer approach for the single zImage IMHO.
> 
> Thanks !
>   -- Daniel
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
