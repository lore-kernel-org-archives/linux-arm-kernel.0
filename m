From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 10:06:20 -0700
Subject: [PATCH 09/14] pinctrl/abx500: use direct IRQ defines
In-Reply-To: <20130208082536.GF7519@gmail.com>
References: <1360093715-6348-1-git-send-email-linus.walleij@stericsson.com>
 <1360093715-6348-10-git-send-email-linus.walleij@stericsson.com>
 <5112F1B9.6010700@wwwdotorg.org>
 <CAF2Aj3jHe+mP0dU_BHThBV-va_iJLcFQedmWQOTaYafAZM1Yxg@mail.gmail.com>
 <5113EB8B.4060002@wwwdotorg.org> <20130208082536.GF7519@gmail.com>
Message-ID: <5115308C.5010400@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 01:25 AM, Lee Jones wrote:
> On Thu, 07 Feb 2013, Stephen Warren wrote:
> 
>> On 02/07/2013 02:01 AM, Lee Jones wrote:
>>> I don't see myself on cc. Was that intentional?
>>
>> The original patch was that way; I assume git send-email only CC'd you
>> on patches written by you.
> 
> No, I didn't send this patch at all.
> 
> I was asking Linus if he ment to CC me, as I thought I should have been.
> 
>>> I quite like the idea of this.
>>>
>>> Stephen,
>>>
>>> It doesn't mean the other patch was wrong, it just transfers the math.
>>
>> Ah, I see. The issue is that the code below clearly calculates the hwirq
>> differently, and it wasn't immediately obvious that this part of the
>> patch for example:
>>
>>>  struct abx500_gpio_irq_cluster ab8500_gpio_irq_cluster[] = {
>>> -	GPIO_IRQ_CLUSTER(6,  13, 34),
>>> -	GPIO_IRQ_CLUSTER(24, 25, 24),
>>> -	GPIO_IRQ_CLUSTER(36, 41, 14),
>>> +	GPIO_IRQ_CLUSTER(6,  13, AB8500_INT_GPIO6R),
>>> +	GPIO_IRQ_CLUSTER(24, 25, AB8500_INT_GPIO24R),
>>> +	GPIO_IRQ_CLUSTER(36, 41, AB8500_INT_GPIO36R),
>>>  };
>>
>> ... actually changes the values in the table (AB8500_INT_GPIO6R is 40,
>> so when using that value, you need to subtract of the value 6 for the
>> base to get the original 34).
> 
> Yes, I see how that may of looked if you didn't see the other change.
> 
> So you're happy?

Yes.
