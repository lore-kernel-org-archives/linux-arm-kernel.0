From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 12 Jun 2014 00:13:53 +0900
Subject: [PATCH] ARM: Exynos : Fix build error with thumb2
In-Reply-To: <CA+iXiiO8ED9rdyxXh9ooDhb9OcBRH52acbqA7cgGX9kvgYaCXg@mail.gmail.com>
References: <1401119625-11309-1-git-send-email-santosh.shukla@linaro.org>	<20140602101023.GB3855@e103592.cambridge.arm.com>
 <CA+iXiiO8ED9rdyxXh9ooDhb9OcBRH52acbqA7cgGX9kvgYaCXg@mail.gmail.com>
Message-ID: <53987231.6080200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/04/14 17:07, Santosh Shukla wrote:
> On 2 June 2014 15:40, Dave Martin<Dave.Martin@arm.com>  wrote:
>> On Mon, May 26, 2014 at 09:23:45PM +0530, Santosh Shukla wrote:
>>> From: santosh shukla<santosh.shukla@linaro.org>
>>>
>>> Add non-global symbol .LLl2x0_regs_phys to avoid build break in thumb2 mode.
>>>
>>> IIUC, arm assembler fail to load value of "global" variable
>>> l2xo_regs_phys for thum2 mode and wrapping it in non-global symbol like
>>> .Ll2x0_regs_phys solves the build break issue.
>>>
>>> arch/arm/mach-exynos/sleep.S: Assembler messages:
>>> arch/arm/mach-exynos/sleep.S:57: Error: invalid immediate for address
>>> calculation (value = 0x00000004)
>>>
>>> fix inspired from [1]
>>>
>>> [1] https://lkml.org/lkml/2010/3/31/235
>>>
>>> Signed-off-by: santosh shukla<santosh.shukla@linaro.org>
>>
>> Reviewed-by: Dave Martin<Dave.Martin@arm.com>
>>
>
> Thanks.
>
> Hi Kukjin, if this patch ok with you then can you pick it up.
>
Sure, I've applied this into fixes for 3.16.

Thanks,
Kukjin


>> The binutils folks insist that this is not a bug in gas.  (I disagreed, but
>> it's a grey area.)  This is the established pattern for working round this
>> issue -- looks fine to me.
>>
>> Cheers
>> ---Dave
