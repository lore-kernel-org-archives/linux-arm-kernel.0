From: linux.amoon@gmail.com (Anand Moon)
Date: Tue, 13 Oct 2015 08:15:36 +0530
Subject: [PATCH 2/3] ARM: dts: use vmmc-supply of emmc/sd for
 exynos5422-odroidxu3
In-Reply-To: <561C6ED3.4090101@samsung.com>
References: <1444578364-1384-1-git-send-email-linux.amoon@gmail.com>
 <1444578364-1384-2-git-send-email-linux.amoon@gmail.com>
 <561B3A3E.3030904@samsung.com> <561B49D0.2040305@samsung.com>
 <CANAwSgT=O-AVhQv4TO8ZukK15Ya++Kos_ZEjiFZWiDwNXub0mQ@mail.gmail.com>
 <561BA3F2.5010403@samsung.com>
 <CANAwSgQ7Tm+hrjYqhVS0Og=NsMK1zJSOM+f7pcjHLzFMNKJkpw@mail.gmail.com>
 <561C4BF9.7070705@samsung.com>
 <CANAwSgSvd6Ewpg17YBEMR=_tmzhrcEXe5aqNP7XWg3r=Ym-dqA@mail.gmail.com>
 <561C6ED3.4090101@samsung.com>
Message-ID: <CANAwSgQ80_+AQjo7gi_az1O+2=tjpFu6H3Pcx9K6oL-URzjCwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jaehoon Chung,

On 13 October 2015 at 08:09, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> On 10/13/2015 11:29 AM, Anand Moon wrote:
>> Hi Krzysztof,
>>
>> On 13 October 2015 at 05:40, Krzysztof Kozlowski
>> <k.kozlowski@samsung.com> wrote:
>>> On 12.10.2015 23:33, Anand Moon wrote:
>>>> Hi Krzysztof,
>>>>
>>>> On 12 October 2015 at 17:43, Krzysztof Kozlowski
>>>> <k.kozlowski@samsung.com> wrote:
>>>>> W dniu 12.10.2015 o 20:08, Anand Moon pisze:
>>>>>> Hi Krzysztof,
>>>>>>
>>>>>> On 12 October 2015 at 11:19, Krzysztof Kozlowski
>>>>>> <k.kozlowski@samsung.com> wrote:
>>>>>>> On 12.10.2015 13:42, Krzysztof Kozlowski wrote:
>>>>>>>> On 12.10.2015 00:46, Anand Moon wrote:
>>>>>>>>> Added support for vmmc/vqmmc-supply for emmc/sd cards.
>>>>>>>>> Fixed the min values for regulator ldo13_reg (VDDQ_MMC2).
>>>>>>>>
>>>>>>>> I can't see the description of a problem which is fixed. If you fix
>>>>>>>> something, then please describe what is wrong.
>>>>>>>>
>>>>>>>>> Added ramp-delay for LDO9(VDD33_USB3_0).
>>>>>>>>> Added ramp-delay for LDO13(VDDQ_MMC2).
>>>>>>>>> Added ramp-delay for LDO15(ETH_P3V3).
>>>>>>>>>
>>>>>>>>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
>>>>>>>>>
>>>>>>>>> ---
>>>>>>>>> Changes based on git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git v4.4-next/dt-samsung branch
>>>>>>>>>
>>>>>>>>> Note:
>>>>>>>>> Changes need for support of UHS-I highspeed cards.
>>>>>>>>> changes for vqmmc-supply for emmc is not supported.
>>>>>>>>>
>>>>>>>>> [    1.831136] vdd_ldo9: ramp_delay not set
>>>>>>>>> [    1.843049] vdd_ldo13: ramp_delay not set
>>>>>>>>> [    1.850975] vdd_ldo15: ramp_delay not set
>>>>>>>>> [    1.862816] vdd_sd: ramp_delay not set
>>>>>>>>> ---
>>>>>>>>>  arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi | 8 +++++++-
>>>>>>>>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>>>>> index 26decbd..58c06d3 100644
>>>>>>>>> --- a/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>>>>> +++ b/arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi
>>>>>>>>> @@ -157,6 +157,7 @@
>>>>>>>>>                              regulator-min-microvolt = <3000000>;
>>>>>>>>>                              regulator-max-microvolt = <3000000>;
>>>>>>>>>                              regulator-always-on;
>>>>>>>>> +                            regulator-ramp-delay = <12000>;
>>>>>>>>>                      };
>>>>>>>>>
>>>>>>>>>                      ldo10_reg: LDO10 {
>>>>>>>>> @@ -182,9 +183,10 @@
>>>>>>>>>
>>>>>>>>>                      ldo13_reg: LDO13 {
>>>>>>>>>                              regulator-name = "vdd_ldo13";
>>>>>>>>> -                            regulator-min-microvolt = <2800000>;
>>>>>>>>> +                            regulator-min-microvolt = <1800000>;
>>>>>>>>>                              regulator-max-microvolt = <2800000>;
>>>>>>>>>                              regulator-always-on;
>>>>>>>>> +                            regulator-ramp-delay = <12000>;
>>>>>>>>>                      };
>>>>>>>>>
>>>>>>>>>                      ldo15_reg: LDO15 {
>>>>>>>>> @@ -213,6 +215,7 @@
>>>>>>>>>                              regulator-min-microvolt = <2800000>;
>>>>>>>>>                              regulator-max-microvolt = <2800000>;
>>>>>>>>>                              regulator-always-on;
>>>>>>>>> +                            regulator-ramp-delay = <12000>;
>>>>>>>>
>>>>>>>> Where did you get this value from? It looks wrong... My datasheet does
>>>>>>>> not have 12000 uV/uS.
>>>>>>>
>>>>>>
>>>>>>> Anand,
>>>>>>>
>>>>>>> We have actually been here:
>>>>>>> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351601.html
>>>>>>>
>>>>>>> That time you used 8000. I asked the same question - how did you figure
>>>>>>> out the exact value.
>>>>>>>
>>>>>>> Now we have the same question - why 12000?
>>>>>>>
>>>>>>> It is completely fine to make a mistake (I do a lot of them) but please
>>>>>>> try not to make the same mistake again.
>>>>>>>
>>>>>>> BR,
>>>>>>> Krzysztof
>>>>>>
>>>>>> I will focus more in the future to clamp down my mistakes to minimal.
>>>>>>
>>>>>>>
>>>>>>>>
>>>>>>>>>                      };
>>>>>>>>>
>>>>>>>>>                      ldo24_reg: LDO24 {
>>>>>>>>> @@ -338,6 +341,7 @@
>>>>>>>>>      samsung,dw-mshc-ddr-timing = <0 2>;
>>>>>>>>>      samsung,dw-mshc-hs400-timing = <0 2>;
>>>>>>>>>      samsung,read-strobe-delay = <90>;
>>>>>>>>> +    vmmc-supply = <&ldo3_reg>;
>>>>>>>>>      pinctrl-names = "default";
>>>>>>>>>      pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus1 &sd0_bus4 &sd0_bus8 &sd0_cd &sd0_rclk>;
>>>>>>>>>      bus-width = <8>;
>>>>>>>>> @@ -352,6 +356,8 @@
>>>>>>>>>      samsung,dw-mshc-ciu-div = <3>;
>>>>>>>>>      samsung,dw-mshc-sdr-timing = <0 4>;
>>>>>>>>>      samsung,dw-mshc-ddr-timing = <0 2>;
>>>>>>>>> +    vmmc-supply = <&ldo19_reg>;
>>>>>>>>> +    vqmmc-supply = <&ldo13_reg>;
>>>>>>>>
>>>>>>>> It looks wrong. LDO13 is used in one place as VQMMC and in other as
>>>>>>>> VMMC. How did you figure out which regulator supplies which power domain?
>>>>>>>>
>>>>>>
>>>>>> I refer Schematics diagram to XU4_MAIN_REV0.1.pdf
>>>>>>
>>>>>> From the PWR_PMCI_S2MPS11_LDO_CTRL document it LDO13 point to VDDQ_MMC2.
>>>>>>
>>>>>
>>>>> Aaa right, by mistake I thought that you put LDO13 here and in the node
>>>>> before, but there is LDO3, not 13. You did this correctly.
>>>>>
>>>>> But I have two other questions:
>>>>> 1. Maybe these regulators now should not be always-enabled?
>>>>
>>>> regulator-always-on         can be removed: I have tested this.
>>>>
>>>>> 2. Why changing minimum voltage of LDO13 to 1.8V? The schematics says 2.8V.
>>>>>
>>>>
>>>> In the schematics diagram to XU4_MAIN_REV0.1.pdf
>>>>
>>>> >From the EXYNOS5422 MMC UFS diagram CH2 range is VDDQ_MMC2 (1.8V/2.8V).
>>>
>>> Okay, so try to setting it to 1.8V (min and max) and see if it works
>>> correctly.
>>>
>>> On the same diagram few lines below:
>>> VDDQ_MMC2: 2.8V 250mA
>>>
>>
>> You are correct.
>> While working on this issue I tent to encounter make bugs.
>> ---------------------------------------------------------------------------------
>> [    4.713553] random: nonblocking pool is initialized
>> [    4.718423] 14530000.hdmi supply hdmi-en not found, using dummy regulator
>> [    4.726206] exynos-drm exynos-drm: bound 14400000.fimd (ops
>> fimd_component_ops)
>> [    4.732555] exynos-drm exynos-drm: bound 14450000.mixer (ops
>> mixer_component_ops)
>> [    4.740180] exynos-drm exynos-drm: bound 14530000.hdmi (ops
>> hdmi_component_ops)
>> [    4.746936] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
>> [    4.753428] [drm] No driver support for vblank timestamp query.
>> [    4.940794] Console: switching to colour frame buffer device 274x77
>> [    4.995344] exynos-drm exynos-drm: fb0:  frame buffer device
>> [    5.024573] [drm] Initialized exynos 1.0.0 20110530 on minor 0
>> [    5.031164] exynos-dwc3 usb at 12000000: no suspend clk specified
>> [    5.054571] usb 2-1: new full-speed USB device number 2 using exynos-ohci
>> [    5.159527] dwmmc_exynos 12220000.mmc: Busy; trying anyway
>> [    5.163705] mmc_host mmc1: Timeout sending command (cmd 0x202000
>> arg 0x0 status 0x0)
>> ---------------------------------------------------------------------------------
>> This is one bug. related to this changes. It stops booting waiting for
>> the mmc1 card.
>
> It seems that it failed to switch voltage.
>
> Best Regards,
> Jaehoon Chung
>

You are correct. This happens when the min/max value for ldo13_reg is 2.8V.

-Anand Moon
>>
>> -Anand Moon
>>
>>> Best regards,
>>> Krzysztof
>>
>
