From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 Sep 2016 09:40:17 +0200
Subject: [PATCH v2 4/4] ARM: dts: gr8: Add support for the GR8 evaluation
 board
In-Reply-To: <CAGb2v66Ed1u5NaC9ev=ohywCbssy6BnkPcThY2D9O=_eNK1pdA@mail.gmail.com>
References: <20160907145400.27192-1-maxime.ripard@free-electrons.com>
 <20160907145400.27192-5-maxime.ripard@free-electrons.com>
 <CAGb2v66Ed1u5NaC9ev=ohywCbssy6BnkPcThY2D9O=_eNK1pdA@mail.gmail.com>
Message-ID: <20160908074017.GG8913@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 07, 2016 at 11:23:56PM +0800, Chen-Yu Tsai wrote:
> > +&i2c1 {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&i2c1_pins_a>;
> > +       status = "okay";
> > +
> > +       pcf8563: rtc at 51 {
> > +               compatible = "phg,pcf8563";
> > +               reg = <0x51>;
> > +       };
> > +
> > +       wm8978: codec at 1a {
> > +               #sound-dai-cells = <0>;
> > +               compatible = "wlf,wm8978";
> > +               reg = <0x1a>;
> > +       };
> 
> Seems like I2S support will happen soon? :)

Indeed :)

It's not working for the moment, which is why it's not enabled through
a simple-card, but I'll work on it ASAP.

(same thing with SPDIF).

> 
> > +};
> 
> [...]
> 
> > diff --git a/arch/arm/boot/dts/ntc-gr8.dtsi b/arch/arm/boot/dts/ntc-gr8.dtsi
> > index d21cfa3f3c14..cdb7a12946c4 100644
> > --- a/arch/arm/boot/dts/ntc-gr8.dtsi
> > +++ b/arch/arm/boot/dts/ntc-gr8.dtsi
> 
> This looks like the wrong patch. Nevertheless...

Hmmm, indeed.

> 
> > @@ -228,7 +228,7 @@
> >
> >                 axi_gates: clk at 01c2005c {
> >                         #clock-cells = <1>;
> > -                       compatible = "allwinner,sun4i-a10-axi-gates-clk";
> > +                       compatible = "allwinner,sun4i-a10-gates-clk";
> >                         reg = <0x01c2005c 0x4>;
> >                         clocks = <&axi>;
> >                         clock-indices = <0>;
> > @@ -244,7 +244,7 @@
> >                                         <2>, <5>, <6>,
> >                                         <7>, <8>, <9>,
> >                                         <10>, <13>,
> > -                                       <14>, <20>,
> > +                                       <14>, <17>, <20>,
> >                                         <21>, <22>,
> >                                         <28>, <32>, <34>,
> >                                         <36>, <40>, <44>,
> > @@ -254,7 +254,7 @@
> >                                              "ahb_ohci", "ahb_ss", "ahb_dma",
> >                                              "ahb_bist", "ahb_mmc0", "ahb_mmc1",
> >                                              "ahb_mmc2", "ahb_nand",
> > -                                            "ahb_sdram", "ahb_spi0",
> > +                                            "ahb_sdram", "ahb_sdram", "ahb_spi0",
> 
> I don't think this will work. Copy/paste error?

Yes, that was supposed to be ethernet. Sorry.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160908/fb37f880/attachment-0001.sig>
