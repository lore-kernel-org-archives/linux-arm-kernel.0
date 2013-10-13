From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Sun, 13 Oct 2013 12:13:50 +0200
Subject: [PATCH] clocksource: at91/tc: remove deprecated IRQF_DISABLED
In-Reply-To: <525A679A.2060408@overkiz.com>
References: <1381639559-6981-1-git-send-email-michael.opdenacker@free-electrons.com>
 <525A679A.2060408@overkiz.com>
Message-ID: <525A725E.5070308@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/13/2013 11:27 AM, boris brezillon wrote:
> Hello Micheal,
>
> This flag has been removed in a recent submission (see
> https://lkml.org/lkml/2013/10/2/202), and, if I'm correct, is on his way
> for mainlining.

Yes, it has been merged in the tip tree:

https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git/commit/?h=timers/core&id=f51380a75652a4600b34ce384c4ff89ce0a15132

> On 13/10/2013 06:45, Michael Opdenacker wrote:
>> This patch proposes to remove the use of the IRQF_DISABLED flag
>>
>> It's a NOOP since 2.6.35 and it will be removed one day.
>>
>> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.com>
>> ---
>>   drivers/clocksource/tcb_clksrc.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/clocksource/tcb_clksrc.c
>> b/drivers/clocksource/tcb_clksrc.c
>> index 8a61872..2efeb3b 100644
>> --- a/drivers/clocksource/tcb_clksrc.c
>> +++ b/drivers/clocksource/tcb_clksrc.c
>> @@ -180,7 +180,7 @@ static irqreturn_t ch2_irq(int irq, void *handle)
>>
>>   static struct irqaction tc_irqaction = {
>>       .name        = "tc_clkevt",
>> -    .flags        = IRQF_TIMER | IRQF_DISABLED,
>> +    .flags        = IRQF_TIMER,
>>       .handler    = ch2_irq,
>>   };
>>
>>
>


-- 
  <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
