From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 13 Apr 2015 17:18:09 +0100
Subject: [PATCH v4 1/3] genirq: Allow the irqchip state of an IRQ to be
 save/restored
In-Reply-To: <CAJAp7Ogq+4Km=H1o3q3M8F1ntMo3nf=Xt92HSW0N+3OeVaGbSw@mail.gmail.com>
References: <1426676484-21812-1-git-send-email-marc.zyngier@arm.com>	<1426676484-21812-2-git-send-email-marc.zyngier@arm.com>
 <CAJAp7Ogq+4Km=H1o3q3M8F1ntMo3nf=Xt92HSW0N+3OeVaGbSw@mail.gmail.com>
Message-ID: <552BEC41.3080909@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/04/15 18:48, Bjorn Andersson wrote:
> On Wed, Mar 18, 2015 at 4:01 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> There is a number of cases where a kernel subsystem may want to
>> introspect the state of an interrupt at the irqchip level:
>>
>> - When a peripheral is shared between virtual machines,
>>    its interrupt state becomes part of the guest's state,
>>    and must be switched accordingly. KVM on arm/arm64 requires
>>    this for its guest-visible timer
>> - Some GPIO controllers seem to require peeking into the
>>    interrupt controller they are connected to to report
>>    their internal state
>>
>> This seem to be a pattern that is common enough for the core code
>> to try and support this without too many horrible hacks. Introduce
>> a pair of accessors (irq_get_irqchip_state/irq_set_irqchip_state)
>> to retrieve the bits that can be of interest to another subsystem:
>> pending, active, and masked.
>>
>> - irq_get_irqchip_state returns the state of the interrupt according
>>    to a parameter set to IRQCHIP_STATE_PENDING, IRQCHIP_STATE_ACTIVE,
>>    IRQCHIP_STATE_MASKED or IRQCHIP_STATE_LINE_LEVEL.
>> - irq_set_irqchip_state similarly sets the state of the interrupt.
>>
>> Reviewed-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> Tested-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
>> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
>> ---
>
> Sorry for bothering you Thomas, but we have a couple of driver for the
> Qualcomm platforms that depends on this patch (the line level part).

+1

Couple of Qualcomm board support are left incomplete due to missing 
drivers using these patches.
Would be nice to get this patch mainlined sooner.

-srini

> Could you please have a look at it?
>
> Thanks,
> Bjorn
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arm-msm" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
