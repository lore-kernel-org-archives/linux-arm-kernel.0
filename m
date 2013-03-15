From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 15 Mar 2013 11:58:56 +0100
Subject: [PATCH 3/3] ARM: at91: add MPA 1600 DT board
In-Reply-To: <CAGhQ9Vx9D_4LnXOgveQ_vnTa-QfgwTkuLrU=_Et1Z2fD_hDCNg@mail.gmail.com>
References: <1360286756-29705-1-git-send-email-manabian@gmail.com>
 <1360286756-29705-4-git-send-email-manabian@gmail.com>
 <F3DBB1B3EF102E4994C89758CFCA32412C5A08@DBDE01.ent.ti.com>
 <CAGhQ9Vx9D_4LnXOgveQ_vnTa-QfgwTkuLrU=_Et1Z2fD_hDCNg@mail.gmail.com>
Message-ID: <5142FEF0.6070308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 04:56 PM, Joachim Eastwood :
> On 8 February 2013 04:19, Kumar, Anil <anilkumar.v@ti.com> wrote:
>> On Fri, Feb 08, 2013 at 06:55:56, Joachim Eastwood wrote:
>>> Signed-off-by: Joachim Eastwood <manabian@gmail.com>
>>> ---
>>>  arch/arm/boot/dts/Makefile    |  1 +
>>>  arch/arm/boot/dts/mpa1600.dts | 71 +++++++++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 72 insertions(+)
>>>  create mode 100644 arch/arm/boot/dts/mpa1600.dts
>>>
>>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>>> index 5ebb44f..8bfb5f3 100644
>>> --- a/arch/arm/boot/dts/Makefile
>>> +++ b/arch/arm/boot/dts/Makefile
>>> @@ -3,6 +3,7 @@ ifeq ($(CONFIG_OF),y)
>>>  # Keep at91 dtb files sorted alphabetically for each SoC
>>>  # rm9200
>>>  dtb-$(CONFIG_ARCH_AT91) += at91rm9200ek.dtb
>>> +dtb-$(CONFIG_ARCH_AT91) += mpa1600.dtb
>>>  # sam9260
>>>  dtb-$(CONFIG_ARCH_AT91) += animeo_ip.dtb
>>>  dtb-$(CONFIG_ARCH_AT91) += aks-cdu.dtb
>>> diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
>>> new file mode 100644
>>> index 0000000..927972a
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/mpa1600.dts
>>> @@ -0,0 +1,71 @@
>>> +/*
>>> + * mpa1600.dts - Device Tree file for Phontech MPA 1600
>>> + *
>>> + *  Copyright (C) 2013 Joachim Eastwood <manabian@gmail.com>
>>> + *
>>> + * Licensed under GPLv2 only
>>> + */
>>> +/dts-v1/;
>>> +/include/ "at91rm9200.dtsi"
>>> +
>>> +/ {
>>> +     model = "Phontech MPA 1600";
>>> +     compatible = "phontech,mpa1600", "atmel,at91rm9200";
>>> +
>>> +     memory {
>>> +             reg = <0x20000000 0x4000000>;
>>> +     };
>>> +
>>> +     clocks {
>>> +             #address-cells = <1>;
>>> +             #size-cells = <1>;
>>> +             ranges;
>>> +
>>> +             main_clock: clock at 0 {
>>> +                     compatible = "atmel,osc", "fixed-clock";
>>> +                     clock-frequency = <18432000>;
>>> +             };
>>> +     };
>>> +
>>> +     ahb {
>>> +             apb {
>>> +                     dbgu: serial at fffff200 {
>>> +                             status = "okay";
>>> +                     };
>>> +
>>> +                     macb0: ethernet at fffbc000 {
>>> +                             phy-mode = "rmii";
>>> +                             status = "okay";
>>> +                     };
>>> +
>>> +                     ssc0: ssc at fffd0000 {
>>> +                             status = "okay";
>>> +                     };
>>> +
>>> +                     ssc1: ssc at fffd4000 {
>>> +                             status = "okay";
>>> +                     };
>>> +             };
>>> +
>>> +             usb0: ohci at 00300000 {
>>> +                     num-ports = <1>;
>>> +                     status = "okay";
>>> +             };
>>> +     };
>>> +
>>> +     i2c at 0 {
>>> +             status = "okay";
>>> +     };
>>> +
>>> +     gpio_keys {
>>> +             compatible = "gpio-keys";
>>> +             #address-cells = <1>;
>>> +             #size-cells = <0>;
>>
>> No need to use these address-cells and size-cells properties as
>> child DT node is not Using. Please see the discussion on link
>>
>> http://www.mail-archive.com/linux-samsung-soc at vger.kernel.org/msg15590.html
> 
> I see.
> 
> Thanks for the feedback. I'll update this patch in the series.

I have modified it and queued the whole series in the:
at91-3.10-dt branch.


> I assume someone will clean up all the other dts files or we'll never
> get rid of these properties as people will copy-paste stuff.

Just done in a new patch:
[PATCH] ARM: at91/dt: gpio-keys: remove address-cells and size-cells
properties


Best regards,
-- 
Nicolas Ferre
