From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 8 Nov 2018 16:10:28 +0000
Subject: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
In-Reply-To: <20181108165940.64ad52f1@windsurf>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org> <20181009115713.GE6248@arm.com>
 <CAL_JsqJh08wZCyGxg7HMbtKjOJTZKMoQcNOB_hPuSfJKQQK8JA@mail.gmail.com>
 <08738708-1c38-fab7-eb34-694e5f4d4b7e@arm.com>
 <20181108165940.64ad52f1@windsurf>
Message-ID: <8eb3b6e5-6dc4-491f-5988-d9cb2031054d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/11/2018 15:59, Thomas Petazzoni wrote:
> Hello,
> 
> I'm jumping into the discussion, but I clearly don't have all the
> context of the discussion.
> 
> On Thu, 8 Nov 2018 15:54:31 +0000, Robin Murphy wrote:
> 
>>>> This seems like a semantic different between the two representations, or am
>>>> I missing something here? Specifically, both the introduction of
>>>> interrupts-extended and also dropping any mention of using a single per-cpu
>>>> interrupt (the single combined case is no longer support by Linux; not sure
>>>> if you want to keep it in the binding).
>>>
>>> In regards to no support for the single combined interrupt, it looks
>>> like Marvell Armada SoCs at least (armada-375 is what I'm looking at)
>>> have only a single interrupt. Though the interrupt gets routed to MPIC
>>> which then has a GIC PPI. So it isn't supported or happens to work
>>> still since it is a PPI?
>>
>> Well, the description of the MPIC in the Armada XP functional spec says:
>>
>> "Interrupt sources ID0?ID28 are private events per CPU. Thus, each
>> processor has a different set of events map interrupts ID0?ID28."
>>
>> Odd grammar aside, that would seem to imply that <&mpic 3> is a per-cpu
>> interrupt itself, thus AFAICS so long as it's cascaded to a GIC PPI and
>> not an SPI then there's no issue there.
> 
> The Armada XP does not have a GIC at all, but only a MPIC as the
> primary interrupt controller.
> 
> However the Armada 38x has both a GIC and a MPIC, and indeed the parent
> interrupts of the MPIC towards the GIC is:
> 
> 	interrupts = <GIC_PPI 15 IRQ_TYPE_LEVEL_HIGH>;

Yeah, perhaps I should have clarified that the XP manual was the only 
publicly-available one I could find, but I'm inferring from the binding 
and driver that the MPIC in 375/38x still behaves the same.

Robin.
