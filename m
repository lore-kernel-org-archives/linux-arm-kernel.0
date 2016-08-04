From: kbeldan@baylibre.com (Karl Beldan)
Date: Thu, 4 Aug 2016 20:53:05 +0000
Subject: [PATCH] ARM: dts: da850: Adjust the pinctrl muxing for the NAND
 on CS3
In-Reply-To: <CAJaRCXMBi-UQaXkGNaSaKjb6eqoJwhcc9Py8vFEWpVKSn5g5bQ@mail.gmail.com>
References: <20160803170627.1773-1-kbeldan@baylibre.com>
 <CAJaRCXMBi-UQaXkGNaSaKjb6eqoJwhcc9Py8vFEWpVKSn5g5bQ@mail.gmail.com>
Message-ID: <20160804205305.GA15013@gobelin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 04, 2016 at 08:42:19PM +0000, Karl Beldan wrote:
> 2016-08-03 17:06 GMT+00:00 Karl Beldan <kbeldan@baylibre.com>:
> 
> > - Adjust the settings to also allow driving EMA_D[8..15] for 16bits
> >   NANDs. These are shared with GPIO3[0..7] which have no in-tree user.
> > - Remove the useless CS4 setting
> >
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> > ---
> >  arch/arm/boot/dts/da850.dtsi | 12 ++++++++----
> >  1 file changed, 8 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
> > index 3a00978..ae5dc18 100644
> > --- a/arch/arm/boot/dts/da850.dtsi
> > +++ b/arch/arm/boot/dts/da850.dtsi
> > @@ -43,16 +43,20 @@
> >
> >                         nand_cs3_pins: pinmux_nand_pins {
> >                                 pinctrl-single,bits = <
> > -                                       /* EMA_OE, EMA_WE */
> > -                                       0x1c 0x00110000  0x00ff0000
> > -                                       /* EMA_CS[4],EMA_CS[3]*/
> > -                                       0x1c 0x00000110  0x00000ff0
> > +                                       /* EMA_OE, EMA_WE, EMA_CS[3] */
> > +                                       0x1c 0x00110010  0x00ff00f0
> >                                         /*
> >                                          * EMA_D[0], EMA_D[1], EMA_D[2],
> >                                          * EMA_D[3], EMA_D[4], EMA_D[5],
> >                                          * EMA_D[6], EMA_D[7]
> >                                          */
> >                                         0x24 0x11111111  0xffffffff
> > +                                       /*
> > +                                        * EMA_D[8],  EMA_D[9],  EMA_D[10],
> > +                                        * EMA_D[11], EMA_D[12], EMA_D[13],
> > +                                        * EMA_D[14], EMA_D[15]
> > +                                        */
> > +                                       0x20 0x11111111  0xffffffff
> >                                         /* EMA_A[1], EMA_A[2] */
> >                                         0x30 0x01100000  0x0ff00000
> >                                 >;
> > --
> > 2.9.0.rc1
> >
Please discard this one I think it is better that I make groups for the
NAND.
 
Karl
