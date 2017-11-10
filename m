From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 10 Nov 2017 06:50:15 +0100
Subject: [PATCH v2 2/2] ARM: sun8i: bananapi-m3: Enable dwmac-sun8i
In-Reply-To: <CAGb2v6670K24MTQ8NWGDF8e2iXB+Okghp51kMD7rADgviQ65fg@mail.gmail.com>
References: <20171109082950.21124-1-clabbe.montjoie@gmail.com>
 <20171109082950.21124-3-clabbe.montjoie@gmail.com>
 <CAGb2v6670K24MTQ8NWGDF8e2iXB+Okghp51kMD7rADgviQ65fg@mail.gmail.com>
Message-ID: <20171110055015.GA11040@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 10, 2017 at 11:48:11AM +0800, Chen-Yu Tsai wrote:
> On Thu, Nov 9, 2017 at 4:29 PM, Corentin Labbe
> <clabbe.montjoie@gmail.com> wrote:
> > The dwmac-sun8i hardware is present on the bananapi m3
> > It uses an external PHY rtl8211e via RGMII.
> >
> > This patch create the needed emac and phy nodes.
> >
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > index c606af3dbfed..45bdd5c17829 100644
> > --- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > +++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
> > @@ -52,6 +52,7 @@
> >         compatible = "sinovoip,bpi-m3", "allwinner,sun8i-a83t";
> >
> >         aliases {
> > +               ethernet0 = &emac;
> >                 serial0 = &uart0;
> >         };
> >
> > @@ -88,6 +89,23 @@
> >         /* TODO GL830 USB-to-SATA bridge downstream w/ GPIO power controls */
> >  };
> >
> > +&emac {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&emac_rgmii_pins>;
> > +       phy-handle = <&ext_rgmii_phy>;
> > +       phy-mode = "rgmii";
> 
> Schematics say PHY is power by DC1SW from the PMIC.
> Not sure why you don't need that. Have you tested your patch?

Tested on 4.14.0-rc5-next-20171018+ 
I will try to check which uboot is used, perhaps it's an old uboot with some PMIC hack.

Thanks
Regards
