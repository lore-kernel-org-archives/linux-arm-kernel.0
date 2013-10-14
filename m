From: rmallon@gmail.com (Ryan Mallon)
Date: Tue, 15 Oct 2013 10:36:56 +1100
Subject: [PATCH] ARM: ep93xx: remove deprecated IRQF_DISABLED
In-Reply-To: <DC148C5AA1CEBA4E87973D432B1C2D8817DAB036@P3PWEX4MB008.ex4.secureserver.net>
References: <1381547439-4888-1-git-send-email-michael.opdenacker@free-electrons.com>
 <DC148C5AA1CEBA4E87973D432B1C2D8817DAB036@P3PWEX4MB008.ex4.secureserver.net>
Message-ID: <525C8018.3070805@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/10/13 02:47, Hartley Sweeten wrote:
> On Friday, October 11, 2013 8:11 PM, Michael Opdenacker wrote:
>> This patch proposes to remove the use of the IRQF_DISABLED flag
>>
>> It's a NOOP since 2.6.35 and it will be removed one day.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
>> ---
>>  arch/arm/mach-ep93xx/core.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
>> index 3f12b88..fcc965f 100644
>> --- a/arch/arm/mach-ep93xx/core.c
>> +++ b/arch/arm/mach-ep93xx/core.c
>> @@ -136,7 +136,7 @@ static irqreturn_t ep93xx_timer_interrupt(int irq, void *dev_id)
>>  
>>  static struct irqaction ep93xx_timer_irq = {
>>  	.name		= "ep93xx timer",
>> -	.flags		= IRQF_DISABLED | IRQF_TIMER | IRQF_IRQPOLL,
>> +	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
>>  	.handler	= ep93xx_timer_interrupt,
>>  };
>>  
> 
> Acked-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Applied to ep93xx-fixes.

Thanks,
~Ryan
