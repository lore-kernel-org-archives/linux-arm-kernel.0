From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 18 Dec 2015 11:35:36 +0000
Subject: [PATCH v10 1/4] dt-binding:Documents of the mbigen bindings
In-Reply-To: <20151218105837.GB29219@leverpostej>
References: <1450353397-47668-1-git-send-email-majun258@huawei.com>
 <1450353397-47668-2-git-send-email-majun258@huawei.com>
 <20151217135247.GD13389@leverpostej> <5673683C.2080304@huawei.com>
 <20151218105837.GB29219@leverpostej>
Message-ID: <5673EF88.80205@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18/12/15 10:58, Mark Rutland wrote:
> On Fri, Dec 18, 2015 at 09:58:20AM +0800, majun (F) wrote:
>> Hi Mark:
>>
>> ? 2015/12/17 21:52, Mark Rutland ??:
>>> On Thu, Dec 17, 2015 at 07:56:34PM +0800, MaJun wrote:
>>>> From: Ma Jun <majun258@huawei.com>
>> [...]
>>>> +- compatible: Should be "hisilicon,mbigen-v2"
>>>> +
>>>> +- reg: Specifies the base physical address and size of the Mbigen
>>>> +  registers.
>>>> +
>>>> +- interrupt controller: Identifies the node as an interrupt controller
>>>> +
>>>> +- msi-parent: Specifies the MSI controller this mbigen use.
>>>> +  For more detail information,please refer to the generic msi-parent binding in
>>>> +  Documentation/devicetree/bindings/interrupt-controller/msi.txt.
>>>> +
>>>> +- num-msis:Specifies the total number of interrupt this device has.
>>>
>>> Is this the number of pins implemented? Or the number of pins that are
>>> in use?
>>>
>>> The latter feels like something we can derive.
>>
>> num-msis means the total number of pins implemented.
> 
> Ok. In that case I think it should be:
> 
> - num-pins: the total number of pins implemented in this Mbigen
>   instance.
> 
> (with the appropriate fixups in the driver).
> 
> With that:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
>>>> +- #interrupt-cells : Specifies the number of cells needed to encode an
>>>> +  interrupt source. The value must be 2.
>>>> +
>>>> +  The 1st cell is hardware pin number of the interrupt.This number is local to
>>>> +  each mbigen chip and in the range from 0 to the maximum interrupts number
>>>> +  of the mbigen.
>>>
>>> Just to check: 0 - 63 represent the "reserved" pins, yes?
>>
>> Yes, you are right.
>>
>>>
>>> Other than those questions, this looks good to me.
>>
>> Do i need to post a new patch to update these two questions?
> 
> Hopefully not.
> 
> Marc, are you happy to fold in the s/num-msis/num-pins/ change?

FWIW, I'm also moving this to:

Documentation/devicetree/bindings/interrupt-controller/hisilicon,mbigen-v2.txt

in order to match the new documentation conventions.

Thanks,

	M.

-- 
Jazz is not dead. It just smells funny...
