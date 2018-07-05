From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 6 Jul 2018 00:01:55 +0200
Subject: [PATCH 3/3] ARM: dts: Add devicetree for Storlink/Storm SL93512R
In-Reply-To: <20180704205627.GF23469@lunn.ch>
References: <20180704191759.12577-1-linus.walleij@linaro.org>
 <20180704191759.12577-3-linus.walleij@linaro.org>
 <20180704205627.GF23469@lunn.ch>
Message-ID: <CACRpkdbgoVjCaTE3xg1Q_-UKG3cdVdDdNFW4j1UOA9bX0o-wpQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 4, 2018 at 10:56 PM Andrew Lunn <andrew@lunn.ch> wrote:
> On Wed, Jul 04, 2018 at 09:17:59PM +0200, Linus Walleij wrote:


> > +                             vsc: port at 6 {
> > +                                     reg = <6>;
> > +                                     label = "cpu";
> > +                                     ethernet = <&gmac1>;
> > +                                     phy-mode = "rgmii";
> > +                                     fixed-link {
> > +                                             speed = <1000>;
> > +                                             full-duplex;
> > +                                             pause;
> > +                                     };

So this DSA side is fine like so.
(...)

> > +             ethernet at 60000000 {
> > +                     status = "okay";
> > +
> > +                     ethernet-port at 0 {
> > +                             phy-mode = "rgmii";
> > +                             phy-handle = <&phy0>;
> > +                     };
> > +                     ethernet-port at 1 {
> > +                             phy-mode = "rgmii";
> > +                             phy-handle = <&vsc>;
>
> This looks odd. The switch port is not a PHY. Normally you use a
> fixed-phy.

I tried some stuff but can't figure this out any other way that also
works :(

I guess you mean a fixed-link as the kernel has no references
to fixed-phy.

This works:

            ethernet-port at 1 {
                phy-mode = "rgmii";
                phy-handle = <&vsc>;
                fixed-link {
                    speed = <1000>;
                    full-duplex;
                    pause;
                };
            };

Is it better? It is still using phy-handle... I couldn't find a way to live
without that. But maybe this was all you expected? phy-mode
and phy-handle still OK despite being named phy-something?

Or do you have some example of how it should look?

Yours,
Linus Walleij
