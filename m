From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 24 May 2013 22:15:39 +0200
Subject: [PATCHv3 5/6] ARM: cubieboard: Enable ethernet (EMAC) support in
 dts
In-Reply-To: <519F62B3.8090302@elopez.com.ar>
References: <1369387394-9453-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369387394-9453-6-git-send-email-maxime.ripard@free-electrons.com>
 <519F62B3.8090302@elopez.com.ar>
Message-ID: <20130524201539.GB17847@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Emilio,

On Fri, May 24, 2013 at 09:53:07AM -0300, Emilio L?pez wrote:
> Hi,
> 
> El 24/05/13 06:23, Maxime Ripard escribi?:
> > From: Stefan Roese <sr@denx.de>
> > 
> > Signed-off-by: Stefan Roese <sr@denx.de>
> > ---
> >  arch/arm/boot/dts/sun4i-a10-cubieboard.dts | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> > index b70fe0d..32d9b18 100644
> > --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> > +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> > @@ -27,6 +27,21 @@
> >  	};
> >  
> >  	soc at 01c20000 {
> > +		emac: ethernet at 01c0b000 {
> > +			pinctrl-names = "default";
> > +			pinctrl-0 = <&emac_pins_a>;
> > +			phy = <&phy0>;
> > +			status = "okay";
> > +		};
> > +
> > +		mdio at 01c0b080 {
> > +			status = "okay";
> > +
> > +			phy0: ethernet-phy at 0 {
> > +				reg = <0>;
> > +			};
> 
> During my testing I found out that I needed to use 1 as reg for the
> driver to work. You can find a fixup patch enclosed that changes this;
> it's possible that some extra changes may also be needed (s/phy0/phy1/
> on the node?)

Merged, thanks for noticing!

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
