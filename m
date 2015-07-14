From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 13 Jul 2015 23:08:44 -0600
Subject: [PATCH 3/4] irqchip: Add documentation for the bcm2836 interrupt
 controller.
In-Reply-To: <87io9r9qsi.fsf@eliezer.anholt.net>
References: <1436303617-17185-1-git-send-email-eric@anholt.net>
 <1436303617-17185-4-git-send-email-eric@anholt.net>
 <55A0A251.1010301@wwwdotorg.org> <87io9r9qsi.fsf@eliezer.anholt.net>
Message-ID: <55A4995C.4050701@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/11/2015 12:01 AM, Eric Anholt wrote:
> Stephen Warren <swarren@wwwdotorg.org> writes:
> 
>> On 07/07/2015 03:13 PM, Eric Anholt wrote:
>>> This is a new per-cpu root interrupt controller on the
>>> Raspberry Pi 2, which will chain to the bcm2835 interrupt
>>> controller for peripheral interrupts.
>> 
>>> diff --git
>>> a/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
>>> b/Documentation/devicetree/bindings/interrupt-controller/brcm,bcm2836-l1-intc.txt
>>
>>>
>>> 
+local_intc: local_intc {
>> 
>>> +	interrupt-parent = <&local_intc>;
>> 
>> I think that property shouldn't be there?
> 
> If you don't have it there, the core finds the interrupt-parent in
> the parent node, and waits for that one before initializing (which
> is in turn waiting for us).  Note that for original 2835, you're
> finding the parent node as well.

Ah yes. It does indeed look like it's typical that the root IRQ
controller points at itself.
