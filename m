From: kiran.padwal@smartplayin.com (kiran.padwal at smartplayin.com)
Date: Mon, 18 Aug 2014 11:48:03 -0400 (EDT)
Subject: [PATCH] ARM: apq8064: Add pinmux and i2c pinctrl nodes
In-Reply-To: <1408129739.03949271@apps.rackspace.com>
References: <1408129739.03949271@apps.rackspace.com>
Message-ID: <1408376883.684512744@apps.rackspace.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Friday, August 15, 2014 3:08pm, kiran.padwal at smartplayin.com said:

> 
> On Thursday, August 14, 2014 6:37pm, "Bjorn Andersson" <bjorn@kryo.se> said:
> 
>> On Thu, Aug 14, 2014 at 12:20 AM, Kiran Padwal
>> <kiran.padwal@smartplayin.com> wrote:
>>> diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi
>>> b/arch/arm/boot/dts/qcom-apq8064.dtsi
>>> index 92bf793..fbebf5c 100644
>>> --- a/arch/arm/boot/dts/qcom-apq8064.dtsi
>>> +++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
>>> @@ -70,6 +70,17 @@
>>>                 ranges;
>>>                 compatible = "simple-bus";
>>>
>>> +               qcom_pinmux: pinmux at 800000 {
>>
>> There are (at least) three different pinmuxes in these platforms: TLMM, PMIC
>> GPIO, PMIC MPP. Also this is the phandle that is used to reference the gpio
>> chip throughout the board.
>>
>> So I would like to suggest that we name it "tlmm" or like in the downstream
>> kernel "msmgpio".
> 
> ok. How about "qcomgpio" or rename it to msmgpio?

Thanks for suggestion, I will rename it to "tlmm".

> 
>>
>>> +                       compatible = "qcom,apq8064-pinctrl";
>>> +                       reg = <0x800000 0x4000>;
>>> +
>>> +                       gpio-controller;
>>> +                       #gpio-cells = <2>;
>>> +                       interrupt-controller;
>>> +                       #interrupt-cells = <2>;
>>> +                       interrupts = <0 32 0x4>;
>>
>> I must have gotten this wrong in the dt binding example, sorry about that.
>> interrupts should be <0 16 0x4>.
> 
> Thanks for information. I will update that.
> 
>>
>>> +               };
>>
>> Regards,
>> Bjorn
>>
> 
> 
> 
