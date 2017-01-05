From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 5 Jan 2017 16:16:07 +0800
Subject: [PATCH 05/22] ARM: dtsi: axp209: add AXP209 ADC subnode
In-Reply-To: <1ddf7012-3336-84c2-6392-353b01beea93@free-electrons.com>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-6-quentin.schulz@free-electrons.com>
 <CAGb2v66dw=DECuHpLDzHnMP-O4UwZ+RkPsH0RofOGdBa7z7OHw@mail.gmail.com>
 <1ddf7012-3336-84c2-6392-353b01beea93@free-electrons.com>
Message-ID: <CAGb2v67zHf9maNvTVKBZWUTAZFP++PsJt+e3_Mt=Mv4FQ-6FZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 5, 2017 at 4:08 PM, Quentin Schulz
<quentin.schulz@free-electrons.com> wrote:
> On 05/01/2017 06:51, Chen-Yu Tsai wrote:
>> On Tue, Jan 3, 2017 at 12:37 AM, Quentin Schulz
>> <quentin.schulz@free-electrons.com> wrote:
>>> X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
>>> different power supplies connected to the PMIC.
>>>
>>> This adds the ADC subnode for AXP20X PMIC.
>>>
>>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>>> ---
>>>  arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
>>> index 675bb0f..2a4e8ee 100644
>>> --- a/arch/arm/boot/dts/axp209.dtsi
>>> +++ b/arch/arm/boot/dts/axp209.dtsi
>>> @@ -53,6 +53,11 @@
>>>         interrupt-controller;
>>>         #interrupt-cells = <1>;
>>>
>>> +       axp209_adc: axp209_adc {
>>
>> Node name should be generic. Please change it to "adc".
>>
>
> OK, do I keep the label as is?
>
> axp209_adc: adc {

Yup. The label is for dereferencing and stuff, and exists in a global scope.
You wouldn't want 2 label names clashing.

ChenYu

>
> Thanks,
> Quentin
>
> --
> Quentin Schulz, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
