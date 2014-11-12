From: horms@verge.net.au (Simon Horman)
Date: Wed, 12 Nov 2014 17:20:35 +0900
Subject: [PATCH/RFC] ARM: shmobile: koelsch: Add MSIOF1 support to device
 tree
In-Reply-To: <CAMuHMdWyFztuwoatq5mmTp8nifMq8OB6ckud=k-LjKPq6VAnVQ@mail.gmail.com>
References: <1414648385-29514-1-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdWyFztuwoatq5mmTp8nifMq8OB6ckud=k-LjKPq6VAnVQ@mail.gmail.com>
Message-ID: <20141112082034.GT9007@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 30, 2014 at 10:21:43AM +0100, Geert Uytterhoeven wrote:
> On Thu, Oct 30, 2014 at 6:53 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > From: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> >
> > MSIOF1 pin is selected and device is enabled.
> >
> > Signed-off-by: Hisashi Nakamura <hisashi.nakamura.ak@renesas.com>
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > Based on the renesas-devel-20141030-v3.18-rc2 branch of my renesas tree
> >
> >  arch/arm/boot/dts/r8a7791-koelsch.dts | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/r8a7791-koelsch.dts b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > index 523ae4d..2ad0e26 100644
> > --- a/arch/arm/boot/dts/r8a7791-koelsch.dts
> > +++ b/arch/arm/boot/dts/r8a7791-koelsch.dts
> > @@ -286,6 +286,12 @@
> >                 renesas,function = "msiof0";
> >         };
> >
> > +       msiof1_pins: spi2 {
> > +               renesas,groups = "msiof1_clk_c", "msiof1_sync_c", "msiof1_rx_c",
> > +                                "msiof1_tx_c";
> 
> These are GPIO pins 2_15, 2_16, 2_17, 2_18, which are routed to EXIO
> Connector B only. No SPI slave device is present on these pins without
> connecting something to this connector.
> 
> So I'm wondering if this should be put in a separate .dtsi, cfr.
> http://www.spinics.net/lists/linux-sh/msg36486.html?
> 
> What do you think?

Good idea. Should I cook something up?

> > +               renesas,function = "msiof1";
> > +       };
> > +
> >         usb0_pins: usb0 {
> >                 renesas,groups = "usb0";
> >                 renesas,function = "usb0";
> > @@ -420,6 +426,13 @@
> >         };
> >  };
> >
> > +&msiof1 {
> > +       pinctrl-0 = <&msiof1_pins>;
> > +       pinctrl-names = "default";
> > +
> > +       status = "okay";
> > +};
> > +
> >  &i2c2 {
> >         pinctrl-0 = <&i2c2_pins>;
> >         pinctrl-names = "default";
> > --
> > 2.1.1
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
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
