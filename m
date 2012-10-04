From: lars@metafoo.de (Lars-Peter Clausen)
Date: Thu, 04 Oct 2012 20:48:54 +0200
Subject: [PATCH] pwm: Get rid of HAVE_PWM
In-Reply-To: <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de>
 <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
Message-ID: <506DDA16.8070604@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/04/2012 08:29 PM, Thierry Reding wrote:
> On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
>> On 10/04/2012 08:06 AM, Thierry Reding wrote:
>>> [...]
>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>> index 331d574..b38f23d 100644
>>> --- a/arch/mips/Kconfig
>>> +++ b/arch/mips/Kconfig
>>> @@ -219,7 +219,8 @@ config MACH_JZ4740
>>>  	select GENERIC_GPIO
>>>  	select ARCH_REQUIRE_GPIOLIB
>>>  	select SYS_HAS_EARLY_PRINTK
>>> -	select HAVE_PWM
>>> +	select PWM
>>> +	select PWM_JZ4740
>>>  	select HAVE_CLK
>>>  	select GENERIC_IRQ_CHIP
>>
>> I'm not sure if this is such a good idea, not all jz4740 based board
>> necessarily require PWM.
> 
> This really only restores previous behaviour. But I agree that this is
> potentially not what we want. Maybe we should just not select this for
> any boards but rather leave it up to some default configuration. If so
> the patch can be made simpler by just removing the HAVE_PWM entries.

At least for JZ4740 I think that is the better solution.

Thanks,
- Lars
