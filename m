From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Tue, 24 Apr 2018 10:05:53 +0200
Subject: [PATCH v3 2/2] ARM: dts: nes: add Nintendo NES/SuperNES Classic
 Edition support
In-Reply-To: <20180424075505.p6e43yw2juw4fqqw@flea>
References: <20180421164246.8477-1-miquel.raynal@bootlin.com>
 <20180421164246.8477-3-miquel.raynal@bootlin.com>
 <20180423072403.4ip5seys4xyll3yr@flea>
 <20180423122752.364ee649@xps13>
 <20180424075505.p6e43yw2juw4fqqw@flea>
Message-ID: <20180424100553.2e9e6151@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, 24 Apr 2018 09:55:05 +0200, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:

> On Mon, Apr 23, 2018 at 12:27:52PM +0200, Miquel Raynal wrote:
> > > >  	sun8i-r16-parrot.dtb \
> > > >  	sun8i-r40-bananapi-m2-ultra.dtb \
> > > >  	sun8i-v3s-licheepi-zero.dtb \
> > > > diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > > > index 6b9e85b4ba0f..44f3cad3de75 100644
> > > > --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > > > +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > > > @@ -198,6 +198,8 @@
> > > >  			clock-names = "ahb", "mod";
> > > >  			resets = <&ccu RST_BUS_NAND>;
> > > >  			reset-names = "ahb";
> > > > +			pinctrl-names = "default";
> > > > +			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;    
> > > 
> > > This should be in your first patch I guess?  
> > 
> > Actually I think this should not be there but instead, because it is
> > board-related, these two lines should be in the nes-classic.dts' nfc
> > node, right? Other a23/a33/r16 based designs could use the second set
> > of CS/RB pins.  
> 
> Does that ever happen?
> 
> On a theoretical level, then yeah, sure. But if all the boards seen
> out there are using the same setup (which is pretty common), then
> there's no reason not to do it in the DTSI.

Then I will add these two properties in the DTSI in the first patch.

Thanks,
Miqu?l

> 
> Maxime
> 



-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
