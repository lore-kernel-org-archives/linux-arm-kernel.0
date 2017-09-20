From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Wed, 20 Sep 2017 13:16:58 +0200
Subject: [PATCH 3/8] ARM: dts: iwg22m: Enable SDHI1 controller
In-Reply-To: <20170915081144.GI3924@verge.net.au>
References: <1505322341-9480-1-git-send-email-chris.paterson2@renesas.com>
 <1505322341-9480-4-git-send-email-chris.paterson2@renesas.com>
 <20170915081144.GI3924@verge.net.au>
Message-ID: <CAMuHMdVLXauMA_cbFJafHNdX_XHVGccO00vm6mdvgB7-7xh3RA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 15, 2017 at 10:11 AM, Simon Horman <horms@verge.net.au> wrote:
> On Wed, Sep 13, 2017 at 06:05:36PM +0100, Chris Paterson wrote:
>> From: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>>
>> Enable the SDHI1 controller on iWave RZ/G1E SoM.
>>
>> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
>> Signed-off-by: Chris Paterson <chris.paterson2@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

>> --- a/arch/arm/boot/dts/r8a7745-iwg22m.dtsi
>> +++ b/arch/arm/boot/dts/r8a7745-iwg22m.dtsi

>> @@ -54,6 +61,16 @@
>>       status = "okay";
>>  };
>>
>> +&sdhi1 {
>> +     pinctrl-0 = <&sdhi1_pins>;
>> +     pinctrl-names = "default";
>> +
>> +     vmmc-supply = <&reg_3p3v>;
>> +     vqmmc-supply = <&reg_3p3v>;
>> +     cd-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;
>
> No wp-gpios property means this is a ?SD slot, right?

Correct.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
