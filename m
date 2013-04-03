From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 03 Apr 2013 22:49:03 +0200
Subject: [PATCH 8/9] ARM: omap3: cpuidle: enable time keeping
In-Reply-To: <87zjxfzetw.fsf@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org>
 <1364991322-20585-8-git-send-email-daniel.lezcano@linaro.org>
 <87zjxfzetw.fsf@linaro.org>
Message-ID: <515C95BF.6030103@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/03/2013 07:47 PM, Kevin Hilman wrote:
> Daniel Lezcano <daniel.lezcano@linaro.org> writes:
> 
>> The TIME_VALID flag is specified for the different states but
>> the time residency computation is not done, no tk flag, no time
>> computation in the idle function.
>>
>> Set the en_core_tk_irqen flag to activate it.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Acked-by: Kevin Hilman <khilman@linaro.org>
> 
> Also, is this a regression fix that also needs to hit v3.9?

Yes, I think so.


>> ---
>>  arch/arm/mach-omap2/cpuidle34xx.c |    5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
>> index 80392fc..4f67a5b 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
>> @@ -274,8 +274,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device *dev,
>>  static DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>>  
>>  static struct cpuidle_driver omap3_idle_driver = {
>> -	.name =		"omap3_idle",
>> -	.owner =	THIS_MODULE,
>> +	.name             = "omap3_idle",
>> +	.owner            = THIS_MODULE,
>> +	.en_core_tk_irqen = 1,
>>  	.states = {
>>  		{
>>  			.enter		  = omap3_enter_idle_bm,


-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
