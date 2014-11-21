From: Suravee.Suthikulpanit@amd.com (Suthikulpanit, Suravee)
Date: Fri, 21 Nov 2014 16:25:55 +0000
Subject: [PATCH V3] arm64: amd-seattle: Adding device tree for AMD
 Seattle platform
In-Reply-To: <546F50BD.8070501@arm.com>
Message-ID: <D09577B0.9B9B%suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/21/14, 21:48, "Marc Zyngier" <marc.zyngier@arm.com> wrote:

>On 21/11/14 14:40, Suthikulpanit, Suravee wrote:
>> 
>> 
>> On 11/21/14, 19:57, "Marc Zyngier" <marc.zyngier@arm.com> wrote:
>> 
>>>> +	gic: interrupt-controller at e1101000 {
>>>> +		compatible = "arm,gic-400", "arm,cortex-a15-gic";
>>>> +		interrupt-controller;
>>>> +		#interrupt-cells = <3>;
>>>> +		#address-cells = <2>;
>>>> +		#size-cells = <2>;
>>>> +		reg = <0x0 0xe1110000 0 0x1000>,
>>>> +		      <0x0 0xe112f000 0 0x2000>,
>>>> +		      <0x0 0xe1140000 0 0x10000>,
>>>> +		      <0x0 0xe1160000 0 0x10000>;
>>>> +		interrupts = <1 8 0xf04>;
>>>
>>> Are you sure about this one? ARM systems usually have this wired on
>>>PPI9
>>> (interrupt 25)...
>>>
>>> Thanks,
>>>
>>> 	M.
>> 
>> I think you might be right. GIC-400 TRM says that this is should be
>> 25, and used for virtual maintenance interrupts. How can I verify
>> this in Linux? KVM?
>
>KVM is one way, but you'll never see the interrupt firing (we kill the
>interrupt while in HYP, before the kernel gets a chance to see it).
>
>If you effectively have GIC400 on this system, then I know for sure this
>is interrupt 25.

I?ll make the change. Thanks for clarification.

Suravee
>
>Thanks,
>
>	M.
>-- 
>Jazz is not dead. It just smells funny...
