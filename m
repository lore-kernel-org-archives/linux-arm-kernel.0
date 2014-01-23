From: marc.ceeeee@gmail.com (Marc C)
Date: Wed, 22 Jan 2014 17:48:29 -0800
Subject: [PATCH v5 7/8] ARM: brcmstb: gic: add compatible string for
 Broadcom Brahma15
In-Reply-To: <CAGVrzcbPyaSe0aEHt157kz=quvsrBCPOUriCVG27fJfasa45jg@mail.gmail.com>
References: <1390361452-3124-1-git-send-email-marc.ceeeee@gmail.com>
 <1390361452-3124-8-git-send-email-marc.ceeeee@gmail.com>
 <CAGVrzcbPyaSe0aEHt157kz=quvsrBCPOUriCVG27fJfasa45jg@mail.gmail.com>
Message-ID: <52E074ED.5000906@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Florian,

> Do not we also need to update drivers/irqchip/irq-gic.c to look for
> this compatible property? Alternatively should the example DTS contain
> the following:
>
> compatible = "brcm,brahma-b15-gic", "arm,cortex-a15-gic"?

Patch #8 [1] of this series has the "compatible" string set exactly that way. I was
following the pattern seen in the other reference DTS files, where "arm,cortex-a15-gic" is
used as the fall-back.

Thanks,
Marc C

[1] https://lkml.org/lkml/2014/1/21/649

On 01/22/2014 02:40 PM, Florian Fainelli wrote:
> Hi Marc,
> 
> 2014/1/21 Marc Carino <marc.ceeeee@gmail.com>:
>> Document the Broadcom Brahma B15 GIC implementation as compatible
>> with the ARM GIC standard.
>>
>> Signed-off-by: Marc Carino <marc.ceeeee@gmail.com>
>> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> Do not we also need to update drivers/irqchip/irq-gic.c to look for
> this compatible property? Alternatively should the example DTS contain
> the following:
> 
> compatible = "brcm,brahma-b15-gic", "arm,cortex-a15-gic"?
> 
>> ---
>>  Documentation/devicetree/bindings/arm/gic.txt |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/gic.txt b/Documentation/devicetree/bindings/arm/gic.txt
>> index 3dfb0c0..d7409fd 100644
>> --- a/Documentation/devicetree/bindings/arm/gic.txt
>> +++ b/Documentation/devicetree/bindings/arm/gic.txt
>> @@ -15,6 +15,7 @@ Main node required properties:
>>         "arm,cortex-a9-gic"
>>         "arm,cortex-a7-gic"
>>         "arm,arm11mp-gic"
>> +       "brcm,brahma-b15-gic"
>>  - interrupt-controller : Identifies the node as an interrupt controller
>>  - #interrupt-cells : Specifies the number of cells needed to encode an
>>    interrupt source.  The type shall be a <u32> and the value shall be 3.
>> --
>> 1.7.1
>>
> 
> 
> 
