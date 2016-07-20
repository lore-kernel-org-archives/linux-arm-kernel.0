From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 20 Jul 2016 16:40:14 +0300
Subject: [PATCH 2/2] ARM: dts: r8a7792: add SDHI support
In-Reply-To: <CAMuHMdUUZ=gopWOir9PMiDgJ8o+CMp+qG=FLhGg_gHrMYzwgFg@mail.gmail.com>
References: <2441635.ESeLhIjWEX@wasted.cogentembedded.com>
 <8030361.FnpbGzHVP8@wasted.cogentembedded.com>
 <20160717225842.GA25133@verge.net.au>
 <cece2545-52f9-7ddb-36d2-df364a272092@cogentembedded.com>
 <CAMuHMdUUZ=gopWOir9PMiDgJ8o+CMp+qG=FLhGg_gHrMYzwgFg@mail.gmail.com>
Message-ID: <e6246060-fa54-37c1-949d-b93da109dbb9@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/20/2016 11:07 AM, Geert Uytterhoeven wrote:

>>>> --- renesas.orig/arch/arm/boot/dts/r8a7792.dtsi
>>>> +++ renesas/arch/arm/boot/dts/r8a7792.dtsi
>>>> @@ -435,6 +435,18 @@
>>>>                         status = "disabled";
>>>>                 };
>>>>
>>>> +               sdhi0: sd at ee100000 {
>>>> +                       compatible = "renesas,sdhi-r8a7792";
>>>> +                       reg = <0 0xee100000 0 0x200>;
>>>
>>>
>>> I do not have the documentation available to check,
>>
>>    Me nether. The SDHI .zip only includes the manual for E2, H2, and M2.
>>
>>> however, I wonder if
>>> as per 66f47ed0e86d ("ARM: shmobile: r8a7790: tidyup SDHI register size on
>>> DTSI") the register size should be 0x328.
>>
>>    I just don't know...
>
>>>> +                       interrupts = <0 165 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                       dmas = <&dmac0 0xcd>, <&dmac0 0xce>,
>>>> +                              <&dmac1 0xcd>, <&dmac1 0xce>;
>>>> +                       dma-names = "tx", "rx", "tx", "rx";
>>>> +                       clocks = <&mstp3_clks R8A7792_CLK_SDHI0>;
>>>> +                       power-domains = <&sysc R8A7792_PD_ALWAYS_ON>;
>>>> +                       status = "disabled";
>>>> +               };
>>>> +
>>>>                 jpu: jpeg-codec at fe980000 {
>>>>                         compatible = "renesas,jpu-r8a7792",
>>>>                                      "renesas,rcar-gen2-jpu";
>>
>>    I also wonder whether whether a single per-SoC SDHI "compatible" is
>> valid. The registers and their offsets seem to differ b/w SDHI0 and the
>> other SDHI cores...
>
> There's version register.
>
> BTW, given SDHI on V2H doesn't support SDR50/SDR104, unlike the instances
> on other R-Car Gen2 SoCs, can you please tell us the version value, as read
> from CTL_VERSION in sh_mobile_sdhi_sdbuf_width()?

    It's 0xCB0D, the same as on other SoCs.

> Thanks!

    Not at all. :-)

> Gr{oetje,eeting}s,
>
>                         Geert

MBR, Sergei
