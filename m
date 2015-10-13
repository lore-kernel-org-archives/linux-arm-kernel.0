From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 13 Oct 2015 09:10:33 +0900
Subject: [PATCH 2/3] ARM: dts: use vmmc-supply of emmc/sd for
 exynos5422-odroidxu3
In-Reply-To: <CANAwSgQ7Tm+hrjYqhVS0Og=NsMK1zJSOM+f7pcjHLzFMNKJkpw@mail.gmail.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-2-git-send-email-linux.amoon@gmail.com>
 <561B3A3E.3030904@samsung.com> <561B49D0.2040305@samsung.com>
 <CANAwSgT=O-AVhQv4TO8ZukK15Ya++Kos_ZEjiFZWiDwNXub0mQ@mail.gmail.com>
 <561BA3F2.5010403@samsung.com>
 <CANAwSgQ7Tm+hrjYqhVS0Og=NsMK1zJSOM+f7pcjHLzFMNKJkpw@mail.gmail.com>
Message-ID: <561C4BF9.7070705@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12.10.2015 23:33, Anand Moon wrote:
> Hi Krzysztof,
> 
> On 12 October 2015 at 17:43, Krzysztof Kozlowski
> <k.kozlowski@samsung.com> wrote:
>> W dniu 12.10.2015 o 20:08, Anand Moon pisze:
>>> Hi Krzysztof,
>>>
>>> On 12 October 2015 at 11:19, Krzysztof Kozlowski
>>> <k.kozlowski@samsung.com> wrote:
>>>> On 12.10.2015 13:42, Krzysztof Kozlowski wrote:
>>>>> On 12.10.2015 00:46, Anand Moon wrote:
>>>>>> Added support for vmmc/vqmmc-supply for emmc/sd cards.
>>>>>> Fixed the min values for regulator ldo13_reg (VDDQ_MMC2).
>>>>>
>>>>> I can't see the description of a problem which is fixed. If you fix
>>>>> something, then please describe what is wrong.
>>>>>
>>>>>> Added ramp-delay for LDO9(VDD33_USB3_0).
>>>>>> Added ramp-delay for LDO13(VDDQ_MMC2).
>>>>>> Added ramp-delay for LDO15(ETH_P3V3).
>>>>>>
>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>
>>>>>> ---
>>>>>> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
>>>>>>
>>>>>> Note:
>>>>>> Changes need for support of UHS-I highspeed cards.
>>>>>> changes for vqmmc-supply for emmc is not supported.
>>>>>>
>>>>>> [    1.831136] vdd_ldo9: ramp_delay not set
>>>>>> [    1.843049] vdd_ldo13: ramp_delay not set
>>>>>> [    1.850975] vdd_ldo15: ramp_delay not set
>>>>>> [    1.862816] vdd_sd: ramp_delay not set
>>>>>> ---
>>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 8 +++++++-
>>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>> index 26decbd..58c06d3 100644
>>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>> @@ -157,6 +157,7 @@
>>>>>>                              regulator-min-microvolt = <3000000>;
>>>>>>                              regulator-max-microvolt = <3000000>;
>>>>>>                              regulator-always-on;
>>>>>> +                            regulator-ramp-delay = <12000>;
>>>>>>                      };
>>>>>>
>>>>>>                      ldo10_reg: LDO10 {
>>>>>> @@ -182,9 +183,10 @@
>>>>>>
>>>>>>                      ldo13_reg: LDO13 {
>>>>>>                              regulator-name = "vdd_ldo13";
>>>>>> -                            regulator-min-microvolt = <2800000>;
>>>>>> +                            regulator-min-microvolt = <1800000>;
>>>>>>                              regulator-max-microvolt = <2800000>;
>>>>>>                              regulator-always-on;
>>>>>> +                            regulator-ramp-delay = <12000>;
>>>>>>                      };
>>>>>>
>>>>>>                      ldo15_reg: LDO15 {
>>>>>> @@ -213,6 +215,7 @@
>>>>>>                              regulator-min-microvolt = <2800000>;
>>>>>>                              regulator-max-microvolt = <2800000>;
>>>>>>                              regulator-always-on;
>>>>>> +                            regulator-ramp-delay = <12000>;
>>>>>
>>>>> Where did you get this value from? It looks wrong... My datasheet does
>>>>> not have 12000 uV/uS.
>>>>
>>>
>>>> Anand,
>>>>
>>>> We have actually been here:
>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351601.html
>>>>
>>>> That time you used 8000. I asked the same question - how did you figure
>>>> out the exact value.
>>>>
>>>> Now we have the same question - why 12000?
>>>>
>>>> It is completely fine to make a mistake (I do a lot of them) but please
>>>> try not to make the same mistake again.
>>>>
>>>> BR,
>>>> Krzysztof
>>>
>>> I will focus more in the future to clamp down my mistakes to minimal.
>>>
>>>>
>>>>>
>>>>>>                      };
>>>>>>
>>>>>>                      ldo24_reg: LDO24 {
>>>>>> @@ -338,6 +341,7 @@
>>>>>>      samsung,dw-mshc-ddr-timing = <0 2>;
>>>>>>      samsung,dw-mshc-hs400-timing = <0 2>;
>>>>>>      samsung,read-strobe-delay = <90>;
>>>>>> +    vmmc-supply = <&ldo3_reg>;
>>>>>>      pinctrl-names = "default";
>>>>>>      pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
>>>>>>      bus-width = <8>;
>>>>>> @@ -352,6 +356,8 @@
>>>>>>      samsung,dw-mshc-ciu-div = <3>;
>>>>>>      samsung,dw-mshc-sdr-timing = <0 4>;
>>>>>>      samsung,dw-mshc-ddr-timing = <0 2>;
>>>>>> +    vmmc-supply = <&ldo19_reg>;
>>>>>> +    vqmmc-supply = <&ldo13_reg>;
>>>>>
>>>>> It looks wrong. LDO13 is used in one place as VQMMC and in other as
>>>>> VMMC. How did you figure out which regulator supplies which power domain?
>>>>>
>>>
>>> I refer Schematics diagram to XU4_MAIN_REV0.1.pdf
>>>
>>> From the PWR_PMCI_S2MPS11_LDO_CTRL document it LDO13 point to VDDQ_MMC2.
>>>
>>
>> Aaa right, by mistake I thought that you put LDO13 here and in the node
>> before, but there is LDO3, not 13. You did this correctly.
>>
>> But I have two other questions:
>> 1. Maybe these regulators now should not be always-enabled?
> 
> regulator-always-on         can be removed: I have tested this.
> 
>> 2. Why changing minimum voltage of LDO13 to 1.8V? The schematics says 2.8V.
>>
> 
> In the schematics diagram to XU4_MAIN_REV0.1.pdf
> 
>>From the EXYNOS5422 MMC UFS diagram CH2 range is VDDQ_MMC2 (1.8V/2.8V).

Okay, so try to setting it to 1.8V (min and max) and see if it works
correctly.

On the same diagram few lines below:
VDDQ_MMC2: 2.8V 250mA

Best regards,
Krzysztof
