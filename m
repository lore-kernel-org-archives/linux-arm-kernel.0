From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 2 Dec 2015 10:09:30 +0800
Subject: [PATCH V3] ARM: dts: imx6q-icore-rqs: Add Engicam IMX6 Q7
 initial support
In-Reply-To: <CAOf5uw=q7fwh93w7LUQaAV3-+YLDwzL65wB1WB5L2BKUe+Vtpg@mail.gmail.com>
References: <1447665552.3144.6.camel@pengutronix.de>
 <20151116112931.GA10464@panicking>
 <1447673895.3144.16.camel@pengutronix.de>
 <20151116114127.GB10464@panicking>
 <1447674695.3144.21.camel@pengutronix.de>
 <20151116115421.GC10464@panicking> <20151116172318.GA513@panicking>
 <1447752697.3144.47.camel@pengutronix.de>
 <20151118151030.GA11558@panicking>
 <CAOf5uw=q7fwh93w7LUQaAV3-+YLDwzL65wB1WB5L2BKUe+Vtpg@mail.gmail.com>
Message-ID: <20151202020930.GD692@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 25, 2015 at 07:14:13PM +0100, Michael Trimarchi wrote:
> Hi Shawn
> 
> On Wed, Nov 18, 2015 at 4:10 PM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> > www.engicam.com/en/products/embedded/som/standard/i-core-rqs-m6s-dl-d-q
> >
> > Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> > ---
> > I'm not quite sure how ethernet tuning parameter
> > are working in other setup and this seems the
> > correct way to use it
> >
> 
> As you can see my way to connect the ethernet phy is different. I have
> seen that most of the boards put all the tuning under fec but unfortunately
> this does not work. I don't know if people check if their value are correctly
> written to the phy.

Hmm, I'm not sure what example you are looking at.  But here is what I
see from arch/arm/boot/dts/imx6qdl-sabrelite.dtsi

&fec {
        pinctrl-names = "default";
        pinctrl-0 = <&pinctrl_enet>;
        phy-mode = "rgmii";
        phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
        txen-skew-ps = <0>;
        txc-skew-ps = <3000>;
        rxdv-skew-ps = <0>;
        rxc-skew-ps = <3000>;
        rxd0-skew-ps = <0>;
        rxd1-skew-ps = <0>;
        rxd2-skew-ps = <0>;
        rxd3-skew-ps = <0>;
        txd0-skew-ps = <0>;
        txd1-skew-ps = <0>;
        txd2-skew-ps = <0>;
        txd3-skew-ps = <0>;
        interrupts-extended = <&gpio1 6 IRQ_TYPE_LEVEL_HIGH>,
                              <&intc 0 119 IRQ_TYPE_LEVEL_HIGH>;
        status = "okay";
};

Shawn

> 
> > +
> > +&fec {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_enet_3>;
> > +       phy-handle = <&eth_phy>;
> > +       phy-mode = "rgmii";
> > +       status = "okay";
> > +       mdio {
> > +               eth_phy: ethernet-phy {
> > +                       rxc-skew-ps = <1140>;
> > +                       txc-skew-ps = <1140>;
> > +                       txen-skew-ps = <600>;
> > +                       rxdv-skew-ps = <240>;
> > +                       rxd0-skew-ps = <420>;
> > +                       rxd1-skew-ps = <600>;
> > +                       rxd2-skew-ps = <420>;
> > +                       rxd3-skew-ps = <240>;
> > +                       txd0-skew-ps = <60>;
> > +                       txd1-skew-ps = <60>;
> > +                       txd2-skew-ps = <60>;
> > +                       txd3-skew-ps = <240>;
> > +               };
> > +       };
> > +};
> > +
