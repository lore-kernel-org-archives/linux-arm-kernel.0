From: john.tobias.ph@gmail.com (John Tobias)
Date: Tue, 17 Dec 2013 10:31:14 -0800
Subject: [PATCH 1/3]: Support cpu frequency scaling and power management
 for iMX6SL
In-Reply-To: <52B09856.5050609@tqsc.de>
References: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
 <CACUGKYN_b0x4xg_Me3TXQGKEvz61SDZk4CFk5YHFnVCWT_6GPg@mail.gmail.com>
 <52B09856.5050609@tqsc.de>
Message-ID: <CACUGKYPr=-5m5D2dWFos233zzmY0KV7YhqU-PRk4C-mBxK6aeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Guys,

Thanks for your input. I will re-submitting my patches later.

Regards,

john

On Tue, Dec 17, 2013 at 10:30 AM, Markus Niebel <list-09@tqsc.de> wrote:
> Am 17.12.2013 03:37, wrote John Tobias:
>> Need some correction:
>>
>> From: John Tobias <john.tobias.ph@gmail.com>
>>
>>
>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>> index 28558f1..6035e7e 100644
>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>> @@ -38,6 +38,21 @@
>>                         device_type = "cpu";
>>                         reg = <0x0>;
>>                         next-level-cache = <&L2>;
>> +                       operating-points = <
>> +                               /* kHz    uV */
>> +                               1000000 1275000
>> +                               996000  1250000
>> +                               792000  1150000
>> +                               396000  950000
>> +                       >;
>> +                       clock-latency = <61036>; /* two CLK32 periods */
>> +                       clocks = <&clks IMX6SL_CLK_ARM>, <&clks
>> IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
>> +                                <&clks IMX6SL_CLK_PLL1_SW>, <&clks
>> IMX6SL_CLK_PLL1_SYS>;
>> +                       clock-names = "arm", "pll2_pfd2_396m", "step",
>> +                                     "pll1_sw", "pll1_sys";
>> +                       arm-supply = <&reg_arm>;
>> +                       pu-supply = <&reg_pu>;
>> +                       soc-supply = <&reg_soc>;
>>                 };
>>         };
>>
>>
>> On Mon, Dec 16, 2013 at 5:40 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>>> iMX6SL device tree doesn't have a configuration settings to enable the
>>> frequency scaling and power management.
>>>
>>> From: John Tobias <john.tobias.ph@gmail.com>
>>>
>>>
>>> diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
>>> index 28558f1..0ad2f6a 100644
>>> --- a/arch/arm/boot/dts/imx6sl.dtsi
>>> +++ b/arch/arm/boot/dts/imx6sl.dtsi
>>> @@ -38,6 +38,19 @@
>>>                         device_type = "cpu";
>>>                         reg = <0x0>;
>>>                         next-level-cache = <&L2>;
>>> +                       operating-points = <
>>> +                               /* kHz    uV */
>>> +                               1000000 1275000
>>> +                               792000  1150000
>
> according to the CPU documentation the following operation points are suggested (at least AFAIK):
>                                996000  1250000 /* for consumer grade only */
>                                792000  1150000
>                                396000  1050000
> note: AFAIK there is no way to detect at runtime if we  running on industrial / automotive variant
> so there is a risk to run at too high frequency ...
>>> +                       >;
>>> +                       clock-latency = <61036>; /* two CLK32 periods */
>>> +                       clocks = <&clks IMX6SL_CLK_ARM>, <&clks
>>> IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
>>> +                                <&clks IMX6SL_CLK_PLL1_SW>, <&clks
>>> IMX6SL_CLK_PLL1_SYS>;
>>> +                       clock-names = "arm", "pll2_pfd2_396m", "step",
>>> +                                     "pll1_sw", "pll1_sys";
>>> +                       arm-supply = <&reg_arm>;
>>> +                       pu-supply = <&reg_pu>;
>>> +                       soc-supply = <&reg_soc>;
>>>                 };
>>>         };
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>
