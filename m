From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Thu, 17 May 2018 15:17:42 +0200
Subject: [PATCH 3/3] arm64: dts: renesas: r8a7795: add ccree binding
In-Reply-To: <CAMuHMdVM55S7+PdnKusX-qkTxioc=0kQ6EGSbwv+kbLk5RCUYw@mail.gmail.com>
References: <1526387370-17142-1-git-send-email-gilad@benyossef.com>
 <1526387370-17142-4-git-send-email-gilad@benyossef.com>
 <CAMuHMdWzeNqsho1V6ezZb81T3_HcRzrtuQpmGXsjtFgt9BtZDQ@mail.gmail.com>
 <20180516074333.i2672u435ymwffk3@verge.net.au>
 <CAOtvUMfFjokOLCg6aHNQESJ_q4Jiok3izrPtae5wR+cND=XL6g@mail.gmail.com>
 <CAMuHMdVM55S7+PdnKusX-qkTxioc=0kQ6EGSbwv+kbLk5RCUYw@mail.gmail.com>
Message-ID: <CAMuHMdUd9A_JG4zvFTtJtKEJF4NFs11vWdG+vCnFAtoqYS0Yog@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2018 at 12:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> On Thu, May 17, 2018 at 10:01 AM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>> On Wed, May 16, 2018 at 10:43 AM, Simon Horman <horms@verge.net.au> wrote:
>>> On Tue, May 15, 2018 at 04:50:44PM +0200, Geert Uytterhoeven wrote:
>>>> On Tue, May 15, 2018 at 2:29 PM, Gilad Ben-Yossef <gilad@benyossef.com> wrote:
>>>> > Add bindings for CryptoCell instance in the SoC.
>>>> >
>>>> > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
>>>>
>>>> Thanks for your patch!
>>>>
>>>> > --- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> > +++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
>>>> > @@ -528,6 +528,14 @@
>>>> >                         status = "disabled";
>>>> >                 };
>>>> >
>>>> > +               arm_cc630p: crypto at e6601000 {
>>>> > +                       compatible = "arm,cryptocell-630p-ree";
>>>> > +                       interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
>>>> > +                       #interrupt-cells = <2>;
>>>>
>>>> I believe the #interrupt-cells property is not needed.
>>>>
>>>> > +                       reg = <0x0 0xe6601000 0 0x1000>;
>>>> > +                       clocks = <&cpg CPG_MOD 229>;
>
> Missing "power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;", as
> the Secure Engine is part of the CPG/MSSR clock domain (see below [*]).

And missing "resets = <&cpg 229>;", as the module is tied to the CPG/MSSR
reset controller.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
