From: pavel@ucw.cz (Pavel Machek)
Date: Mon, 8 Jan 2018 23:20:54 +0100
Subject: [PATCHv3] dt-bindings: Avago APDS990X light sensor
In-Reply-To: <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
References: <20171227091828.GA3307@amd>
 <20171227180000.6ejpbqmr736nqx5i@kekkonen.localdomain>
 <20171227200147.GB16799@amd>
 <20171227211643.nnwtm4j6cyftlm66@kekkonen.localdomain>
 <20180102124450.GA18659@amd>
 <20180105160137.nr7oqvpbp2oao5fm@rob-hp-laptop>
Message-ID: <20180108222054.GA17452@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

> > From: Filip Matijevi? <filip.matijevic.pz@gmail.com>
> > 
> > This prepares binding for light sensor used in Nokia N9.
> 
> "dt-bindings: ..." is the preferred subject prefix.

Ok.

> > +++ b/Documentation/devicetree/bindings/misc/avago-apds990x.txt
> 
> Put this with other light sensors whether you use IIO or not:
> 
> bindings/iio/light/

Makes sense. Patches to convert to IIO are available.

> > @@ -0,0 +1,41 @@
> > +Avago APDS990X driver
> 
> Bindings aren't drivers.

Ok.

> > +https://docs.broadcom.com/docs/AV02-2867EN
> > +
> > +Required properties:
> > +- compatible: "avago,apds990x"
> > +- reg: address on the I2C bus
> > +- interrupts: external interrupt line number
> > +- vdd-supply: power supply for VDD
> > +- vled-supply: power supply for LEDA
> > +- avago,ga: Glass attenuation
> 
> We already have "upisemi,glass-coef". Can we align on something
> common.

upisemi seems to have different units (1/1000 vs. 1/4096). Do you want
me to do change to avago,glass-coef or ....?

> > +- avago,cf1: Clear channel factor 1
> > +- avago,irf1: IR channel factor 1
> > +- avago,cf2: Clear channel factor 2
> > +- avago,irf2: IR channel factor 2
> 
> Perhaps 2 properties with 2 cells for factor 1 and 2.

This is obviously easier to keep, but I can change.

> > +- avago,df: Device factor
> 
> Units/range for all these?

Fixed point, with 4096 == 1.00.

> > +- avago,pdrive: IR current, one of APDS_IRLED_CURR_XXXmA values
> 
> Don't we have standard current property for LEDs?

We do have "led-max-microamp"; which is not quite what this is. I
guess we can do "led-microamp" if you prefer?

> > +- avago,ppcount: Proximity pulse count
> 
> Is this standard for prox sensors?

I don't know many proximity sensors. Seems like way to raise sensitivity.

Best regards,
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180108/d1bebcf2/attachment.sig>
