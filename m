From: sourav.poddar@ti.com (Sourav)
Date: Mon, 22 Oct 2012 18:26:19 +0530
Subject: [PATCH 3/4] ARM/dts: omap5: Update UART with address space and
 interrupts
In-Reply-To: <508540FC.4090107@ti.com>
References: <1350901328-3525-1-git-send-email-s-guiriec@ti.com>
 <1350901328-3525-4-git-send-email-s-guiriec@ti.com> <50852AF9.10703@ti.com>
 <5085348C.60105@ti.com> <508536EA.4020808@ti.com> <50853B94.4060308@ti.com>
 <508540FC.4090107@ti.com>
Message-ID: <50854273.5080504@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 22 October 2012 06:20 PM, Benoit Cousson wrote:
> On 10/22/2012 02:27 PM, Sourav wrote:
>> Hi Benoit,
>> On Monday 22 October 2012 05:37 PM, Benoit Cousson wrote:
>>> On 10/22/2012 01:57 PM, Benoit Cousson wrote:
>>>> Hi Sourav,
>>>>
>>>> On 10/22/2012 01:16 PM, Sourav wrote:
>>>>> Hi Sebastien,
>>>>> On Monday 22 October 2012 03:52 PM, Sebastien Guiriec wrote:
>>>>>> Add base address and interrupt line inside Device Tree data for
>>>>> Incomplete sentence!
>>>>>> Signed-off-by: Sebastien Guiriec <s-guiriec@ti.com>
>>>>>> ---
>>>>>>     arch/arm/boot/dts/omap5.dtsi |   16 ++++++++++++++--
>>>>>>     1 file changed, 14 insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/omap5.dtsi
>>>>>> b/arch/arm/boot/dts/omap5.dtsi
>>>>>> index 6c22e1b..413df94 100644
>>>>>> --- a/arch/arm/boot/dts/omap5.dtsi
>>>>>> +++ b/arch/arm/boot/dts/omap5.dtsi
>>>>>> @@ -237,36 +237,48 @@
>>>>>>               uart1: serial at 4806a000 {
>>>>>>                 compatible = "ti,omap4-uart";
>>>>>> +            reg = <0x4806a000 0x100>;
>>>>>> +            interrupts = <0 72 0x4>;
>>>>>>                 ti,hwmods = "uart1";
>>>>>>                 clock-frequency = <48000000>;
>>>>>>             };
>>>>>>               uart2: serial at 4806c000 {
>>>>>>                 compatible = "ti,omap4-uart";
>>>>>> +            reg = <0x4806c000 0x100>;
>>>>>> +            interrupts = <0 73 0x4>;
>>>>>>                 ti,hwmods = "uart2";
>>>>>>                 clock-frequency = <48000000>;
>>>>>>             };
>>>>>>               uart3: serial at 48020000 {
>>>>>>                 compatible = "ti,omap4-uart";
>>>>>> +            reg = <0x48020000 0x100>;
>>>>>> +            interrupts = <0 74 0x4>;
>>>>>>                 ti,hwmods = "uart3";
>>>>>>                 clock-frequency = <48000000>;
>>>>>>             };
>>>>>>               uart4: serial at 4806e000 {
>>>>>>                 compatible = "ti,omap4-uart";
>>>>>> +            reg = <0x4806e000 0x100>;
>>>>>> +            interrupts = <0 70 0x4>;
>>>>>>                 ti,hwmods = "uart4";
>>>>>>                 clock-frequency = <48000000>;
>>>>>>             };
>>>>>>               uart5: serial at 48066000 {
>>>>>> -            compatible = "ti,omap5-uart";
>>>>>> +            compatible = "ti,omap4-uart";
>>>>>> +            reg = <0x48066000 0x100>;
>>>>>> +            interrupts = <0 105 0x4>;
>>>>> In Omap5 TRM, the interrupt number mentioned for uart5 is 138. How is
>>>>> 105 coming?
>>>> It is from hwmod and thus from the HW spec. It looks like the TRM is
>>>> wrong... or the HW spec :-)
>>>>
>>>>>>                 ti,hwmods = "uart5";
>>>>>>                 clock-frequency = <48000000>;
>>>>>>             };
>>>>>>               uart6: serial at 48068000 {
>>>>>> -            compatible = "ti,omap6-uart";
>>>>>> +            compatible = "ti,omap4-uart";
>>>>>> +            reg = <0x48068000 0x100>;
>>>>>> +            interrupts = <0 106 0x4>;
>>>>> Same here, TRM shows this number to be 139 ?
>>> In fact, even the TRM (ES1.0 NDA vM) is aligned with these data.
>>> Where did you see 138 and 139?
>> I looked at Page 6300 of the above TRM, Figure 24-60. Is this place not
>> correct to look
>> up for these data?
> Nope. Well it should be accurate but since it is a diagram, it does not
> necessarily reflect the latest integration data like IRQ line.
>
> You'd better use the table that list all the IRQ per CPU:
>
> 18.3.2 Interrupt Requests to INTC_MPU
Ahh. True. The table does show the numbers to be 105 and 106.
Thanks for the pointer.

~Sourav
> Regards,
> Benoit
>
