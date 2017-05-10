From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Wed, 10 May 2017 11:42:19 +0200
Subject: [PATCH v4 0/3] Add Mediatek CIRQ interrupt controller
In-Reply-To: <1491558884.24848.3.camel@mtksdaap41>
References: <1491552397-7893-1-git-send-email-youlin.pei@mediatek.com>
 <771954fe-c994-96be-76ab-ece75383d058@arm.com>
 <1491558884.24848.3.camel@mtksdaap41>
Message-ID: <36732dc3-e113-246c-0828-150e9b31f4fb@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 07/04/17 11:54, Youlin Pei wrote:
> On Fri, 2017-04-07 at 09:52 +0100, Marc Zyngier wrote:
>> On 07/04/17 09:06, Youlin Pei wrote:
>>> In Mediatek SOCs, the CIRQ is a low power interrupt controller designed to
>>> works outside MCUSYS which comprises with Cortex-Ax cores,CCI and GIC.
>>>
>>> The CIRQ controller is integrated in between MCUSYS and interrupt sources
>>> as the second level interrupt controller. The external interrupts which
>>> outside MCUSYS will feed through CIRQ then bypass to GIC.
>>>
>>> In normal mode(where MCUSYS is active), CIRQ is disabled and interrupts
>>> will directly issue to MCUSYS. When MCUSYS enters sleep mode, where GIC
>>> is power downed. CIRQ will be enabled and monitor all edge trigger
>>> interrupts(only edge trigger interrupts will be lost in this scenario).
>>> When an edge interrupt is triggered, CIRQ will record the status and
>>> generated a pulse signal to GIC when flush command is executed.
>>>
>>> With CIRQ, MCUSYS can be completely turned off to improve the system
>>> power consumption without losing interrupts.
>>>
>>> change in v4:
>>> 1. add some comment to explain CIRQ suspend callback.
>>> 2. rebase on 4.11
>>
>> Hi Youlin,
>>
>> I'm happy to take the first two patches through the irq tree. How do we
>> deal with the third one? It seems to me that it'd be better routed via
>> armsoc.
>>
>> Let me know what you and Matthias want to do.
> 
> Hi Marc,
> 
> Thanks for your review. I think that driver and dtsi can merged
> separately.
> 
> Hi Matthias,
> Could you help to review the dtsi patch?

queued now for v4.12-next/dts32
sorry for the late answer.

Matthias

> Thanks a lot!
> 
>>
>> Thanks,
>>
>> 	M.
> 
> 
