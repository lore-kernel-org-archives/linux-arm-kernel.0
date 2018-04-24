From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 24 Apr 2018 13:05:39 +0200
Subject: [PATCH v3 2/2] ARM: dts: nes: add Nintendo NES/SuperNES Classic
 Edition support
In-Reply-To: <20180424104911.42ae8864@xps13>
References: <20180421164246.8477-1-miquel.raynal@bootlin.com>
 <20180421164246.8477-3-miquel.raynal@bootlin.com>
 <20180423072403.4ip5seys4xyll3yr@flea>
 <20180423122752.364ee649@xps13>
 <20180424075505.p6e43yw2juw4fqqw@flea>
 <20180424104911.42ae8864@xps13>
Message-ID: <20180424110539.tlni7mb4xpdsunrh@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 10:49:11AM +0200, Miquel Raynal wrote:
> Hi Maxime,
> 
> On Tue, 24 Apr 2018 09:55:05 +0200, Maxime Ripard
> <maxime.ripard@bootlin.com> wrote:
> 
> > On Mon, Apr 23, 2018 at 12:27:52PM +0200, Miquel Raynal wrote:
> > > > >  	sun8i-r16-parrot.dtb \
> > > > >  	sun8i-r40-bananapi-m2-ultra.dtb \
> > > > >  	sun8i-v3s-licheepi-zero.dtb \
> > > > > diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > > > > index 6b9e85b4ba0f..44f3cad3de75 100644
> > > > > --- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > > > > +++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
> > > > > @@ -198,6 +198,8 @@
> > > > >  			clock-names = "ahb", "mod";
> > > > >  			resets = <&ccu RST_BUS_NAND>;
> > > > >  			reset-names = "ahb";
> > > > > +			pinctrl-names = "default";
> > > > > +			pinctrl-0 = <&nand_pins &nand_pins_cs0 &nand_pins_rb0>;    
> > > > 
> > > > This should be in your first patch I guess?  
> > > 
> > > Actually I think this should not be there but instead, because it is
> > > board-related, these two lines should be in the nes-classic.dts' nfc
> > > node, right? Other a23/a33/r16 based designs could use the second set
> > > of CS/RB pins.  
> > 
> > Does that ever happen?
> > 
> > On a theoretical level, then yeah, sure. But if all the boards seen
> > out there are using the same setup (which is pretty common), then
> > there's no reason not to do it in the DTSI.
> 
> I compared the various boards configurations [1] with the R16 datasheet
> [2], all the boards having a NAND configure all the related pins
> (including CS1 and RB1). So I guess I can put both properties in the
> DTSI.

I don't think we should until we have a clearer view of whether it's
needed or not. If it turns out that they are not using it, and that we
need to remove it from the DTSI, it's going to be a nightmare to track
down what board actually needs what pin.

> There is one case (sinlinx_sina33) where the NAND is not used and the
> pins are used for an alternate function: SPI0; but I guess this is not
> a problem as in this case, the NAND node would not exist in the
> resulting DTB.

Yeah, the sinA33 is using an eMMC, so it's not relevant here.

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180424/4d3c9e61/attachment.sig>
