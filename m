From: jacopo@jmondi.org (jacopo mondi)
Date: Fri, 23 Feb 2018 11:06:07 +0100
Subject: [PATCH 6/6] arm64: dts: renesas: r8a77965: Add #interrupt-cells
 property
In-Reply-To: <CAMuHMdUSS_kFU+Zg40UHvtJ=PteftQW_tvViAr-d4r+jmVNfNQ@mail.gmail.com>
References: <1519326370-15805-1-git-send-email-jacopo+renesas@jmondi.org>
 <1519326370-15805-7-git-send-email-jacopo+renesas@jmondi.org>
 <CAMuHMdUSS_kFU+Zg40UHvtJ=PteftQW_tvViAr-d4r+jmVNfNQ@mail.gmail.com>
Message-ID: <20180223100607.GO7203@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geert,

On Fri, Feb 23, 2018 at 10:27:16AM +0100, Geert Uytterhoeven wrote:
> On Thu, Feb 22, 2018 at 8:06 PM, Jacopo Mondi <jacopo+renesas@jmondi.org> wrote:
> > Add "#interrupt-cells" property and "interrupt-controller" label to
> > "interrupt-controller at e61c0000" device node.
> >
> > This silences the following DTC compiler warnings:
> > Warning (interrupts_property): Missing interrupt-controller or
> > interrupt-map property in /soc/interrupt-controller at e61c0000
> > Warning (interrupts_property): Missing #interrupt-cells in
> > interrupt-parent /soc/interrupt-controller at e61c000
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> > --- a/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > +++ b/arch/arm64/boot/dts/renesas/r8a77965.dtsi
> > @@ -316,6 +316,8 @@
> >                 };
> >
> >                 intc_ex: interrupt-controller at e61c0000 {
> > +                       #interrupt-cells = <2>;
> > +                       interrupt-controller;
> >                         reg = <0 0xe61c0000 0 0x200>;
> >                         /* placeholder */
>
> (bikeshedding) Should the placeholder be at the top of the node?

I would like it more too, but in M3-W dtsi:

		pciec0: pcie at fe000000 {
			reg = <0 0xfe000000 0 0x80000>;
			/* placeholder */
		};

So I kept using the same style everywhere here.

I can change it everywhere in this series to have placeholder at the
beginning of the node definition if you agree with that!

Thanks
   j

>
> >                 };
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
