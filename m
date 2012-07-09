From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 9 Jul 2012 14:05:23 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <201207091307.35860.marex@denx.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de>
 <20120709105338.GE1296@pengutronix.de>
 <201207091307.35860.marex@denx.de>
Message-ID: <20120709120523.GG1296@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> > > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > > index ee3778a..832d30a 100644
> > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > +++ b/arch/arm/boot/dts/imx28.dtsi
> [...]
> > > @@ -428,6 +429,7 @@
> > > 
> > >  				compatible = "fsl,imx28-i2c";
> > >  				reg = <0x8005a000 2000>;
> > >  				interrupts = <110 69>;
> > > 
> > > +				clock-frequency = <400000>;
> > 
> > NACK on that. Not all slaves can do 400KHz, so this is not a sensible
> > default.
> 
> How many of such chips are there and how many of the chips can do 400kHz ? I 
> believe the majority shouldn't suffer because of minority.

The kernel should work for all users, not only for the majority, so:
Better safe than sorry.

Also, defaults should make the system work. Tuning can be done later by
somebody who understands what is needed.

And frankly, this attitude which made you add a potential regression is
worrisome. I'd suggest to give stability a higher priority.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120709/e81f2bc3/attachment.sig>
