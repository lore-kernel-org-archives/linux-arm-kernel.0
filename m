From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 26 Jun 2013 01:41:17 +0900
Subject: [PATCH v3 11/18] pwm: Add new pwm-samsung driver
In-Reply-To: <1688471.WOi6pAAcEq@amdc1227>
References: <1371766383-29077-1-git-send-email-tomasz.figa@gmail.com>
 <1405696.in3RSSDWnX@flatron> <20130625102646.GC21137@manwe>
 <1688471.WOi6pAAcEq@amdc1227>
Message-ID: <51C9C82D.6010808@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/25/13 20:19, Tomasz Figa wrote:

[...]

>>>>> /*
>>>>>
>>>>>   * PWM block is shared between pwm-samsung and samsung_pwm_timer
>>>>>   drivers
>>>>>   * and some registers need access synchronization. If both drivers
>>>>>   are
>>>>>   * compiled in, the spinlock is defined in the clocksource driver,
>>>>>   * otherwise following definition is used.
>>>>>   *
>>>>>   * Currently we do not need any more complex synchronization method
>>>>>   * because all the supported SoCs contain only one instance of the
>>>>>   PWM
>>>>>   * IP. Should this change, both drivers will need to be modified to
>>>>>   * properly synchronize accesses to particular instances.
>>>>>   */
>>>>
>>>> I see that you can't be persuaded. And everybody else seems to be
>>>> okay
>>>> with it so... have it your way. I'm probably going to regret this.
>>>
>>> This was just a proposal. Do you want anything else to be added to the
>>> comment or anything to be changed?
>>
>> For reference, I still don't like this but since I'm the only one
>> complaining, go ahead. With that comment added to the driver:
>>
>> Acked-by: Thierry Reding<thierry.reding@gmail.com>
>
> OK. Thank you.
>
> Kukjin, can you amend the comment I mentioned to this patch above the line
> with DEFINE_SPINLOCK or I should send fixed version?
>
Tomasz, please re-send this one with fixing it but I'm not sure this can 
be sent for upcoming merge window because it's a little bit late. 
Anyway, let me try it.

Thanks,
- Kukjin
