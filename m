From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 2 Oct 2017 09:21:31 +0200
Subject: [PATCH 20/22] arm64: dts: renesas: r8a77995: draak: enable
 EthernetAVB
In-Reply-To: <29d4573f-4127-225c-1abc-7f341734d7d7@cogentembedded.com>
References: <cover.1506678250.git.horms+renesas@verge.net.au>
 <4503b50eac08f472e8690ec61f4d144e62cbdc55.1506678250.git.horms+renesas@verge.net.au>
 <29d4573f-4127-225c-1abc-7f341734d7d7@cogentembedded.com>
Message-ID: <CAMuHMdVBXQny03HET3y_JuA+TFq=0ngvMt29XAmpTY0MrzNmKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

On Sat, Sep 30, 2017 at 12:24 PM, Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 9/29/2017 2:52 PM, Simon Horman wrote:
>> From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>>
>> This patch enables EthernetAVB for R-Car D3 draak board.
>>
>> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
>> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

>> --- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>> +++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
>
> [...]
>>
>> @@ -37,6 +39,14 @@
>>   };
>>     &pfc {
>> +       avb0_pins: avb {
>> +               mux {
>> +                       groups = "avb0_link", "avb0_phy_int", "avb0_mdc",
>
>                                               ^^^^^^^^^^^^^^
>    Hum, I don't think it's compatible with routing the PHY interrupt via
> GPIO5_19 below. The driver doesn't support signalling via AVB_PHY_INT
> anyway.

Seems we have the same issue in arch/arm64/boot/dts/renesas/ulcb.dtsi and
arch/arm64/boot/dts/renesas/salvator-common.dtsi?

>>   +&avb {

>> +       phy0: ethernet-phy at 0 {
>> +               rxc-skew-ps = <1500>;
>> +               reg = <0>;
>> +               interrupt-parent = <&gpio5>;
>> +               interrupts = <19 IRQ_TYPE_LEVEL_LOW>;
>> +       };
>> +};

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
