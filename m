From: mpa@pengutronix.de (Markus Pargmann)
Date: Thu, 5 Mar 2015 08:12:52 +0100
Subject: [PATCH v7 1/8] ARM: dt: Binding documentation for imx25 ADC/TSC
In-Reply-To: <2620642.Qp1W4O8uh6@wuerfel>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <1425369498-25541-2-git-send-email-mpa@pengutronix.de>
 <2620642.Qp1W4O8uh6@wuerfel>
Message-ID: <20150305071252.GA8062@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Mar 03, 2015 at 10:02:12AM +0100, Arnd Bergmann wrote:
> On Tuesday 03 March 2015 08:58:11 Markus Pargmann wrote:
> > +Example:
> > +       tscadc: tscadc at 50030000 {
> > +               compatible = "fsl,imx25-tsadc";
> > +               reg = <0x50030000 0xc>;
> > +               interrupts = <46>;
> > +               clocks = <&clks 119>;
> > +               clock-names = "ipg";
> > +               interrupt-controller;
> > +               #interrupt-cells = <1>;
> > +               #address-cells = <1>;
> > +               #size-cells = <1>;
> > +               ranges;
> > +
> > +               tsc: tcq at 50030400 {
> > +                       compatible = "fsl,imx25-tcq";
> > +                       reg = <0x50030400 0x60>;
> > +                       ...
> > +               };
> > +
> > +               adc: gcq at 50030800 {
> > +                       compatible = "fsl,imx25-gcq";
> > +                       reg = <0x50030800 0x60>;
> > +                       ...
> > +               };
> > +       };
> > 
> 
> I wonder if we should just treat this MFD as a single IIO device
> that also registers to the input layer.
> 
> Are there any other registers in the 0x50030000-0x50031000
> range, or could the fsl,imx25-tcq and fsl,imx25-gcq devices
> be reused outside of a fsl,imx25-tsadc device?

There are no other registers in this range. The tcq and gcq devices can
not be used outside of the tsadc. gcq and tcq are identical units so it
may work to use both of them as gcq for example but nothing else.

It may work to have this as single IIO device. However this would be a
major rework of this series. There are a lot less users of imx25 than
imx6 for example. And of these users barely anyone uses this unit at
all. I really would like to get these drivers mainline so others can use
it. But after 1 year and 7 versions of this series I don't want to put
a lot of work into these drivers. I think there are other components in
the kernel where the time is better used.

Best Regards,

Markus

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150305/95f068cb/attachment.sig>
