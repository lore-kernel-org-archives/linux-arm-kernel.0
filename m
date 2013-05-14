From: csd@broadcom.com (Christian Daudt)
Date: Tue, 14 May 2013 07:58:52 -0700
Subject: [PATCH 06/14] ARM: bcm281xx: Remove init_irq declaration in
 machine description
In-Reply-To: <5191F503.2070301@free-electrons.com>
References: <1368438253-28218-1-git-send-email-maxime.ripard@free-electrons.com>
 <1368438253-28218-7-git-send-email-maxime.ripard@free-electrons.com>
 <519147C6.6080004@broadcom.com> <5191F503.2070301@free-electrons.com>
Message-ID: <5192512C.6080006@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-05-14 01:25 AM, Maxime Ripard wrote:
> Hi Christian,
>
> Le 13/05/2013 22:06, Christian Daudt a ?crit :
>> On 13-05-13 02:44 AM, Maxime Ripard wrote:
>>> Commit ebafed7a ("ARM: irq: Call irqchip_init if no init_irq function is
>>> specified") removed the need to explictly setup the init_irq field in
>>> the machine description when using only irqchip_init. Remove that
>>> declaration for bcm281xx as well.
>>>
>>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>>> ---
>>>    arch/arm/mach-bcm/board_bcm.c | 1 -
>>>    1 file changed, 1 deletion(-)
>>>
>>> diff --git a/arch/arm/mach-bcm/board_bcm.c
>>> b/arch/arm/mach-bcm/board_bcm.c
>>> index 22e8421..24556cf 100644
>>> --- a/arch/arm/mach-bcm/board_bcm.c
>>> +++ b/arch/arm/mach-bcm/board_bcm.c
>>> @@ -54,7 +54,6 @@ static void __init board_init(void)
>>>    static const char * const bcm11351_dt_compat[] = { "bcm,bcm11351",
>>> NULL, };
>>>      DT_MACHINE_START(BCM11351_DT, "Broadcom Application Processor")
>>> -    .init_irq = irqchip_init,
>>>        .init_time = clocksource_of_init,
>>>        .init_machine = board_init,
>>>        .dt_compat = bcm11351_dt_compat,
>> Acked-by: Christian Daudt <csd@broadcom.com>
> Thanks!
>
> I forgot to remove the include of irqchip.h into all these patches, so
> I'll send a v2, and I guess you could probably merge it through your
> tree after that directly.
Ok. will do.

  thanks,
    csd
