From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 13:07:35 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120709105338.GE1296@pengutronix.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de>
 <20120709105338.GE1296@pengutronix.de>
Message-ID: <201207091307.35860.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

[...]

> > diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
> > index ee3778a..832d30a 100644
> > --- a/arch/arm/boot/dts/imx28.dtsi
> > +++ b/arch/arm/boot/dts/imx28.dtsi
[...]
> > @@ -428,6 +429,7 @@
> > 
> >  				compatible = "fsl,imx28-i2c";
> >  				reg = <0x8005a000 2000>;
> >  				interrupts = <110 69>;
> > 
> > +				clock-frequency = <400000>;
> 
> NACK on that. Not all slaves can do 400KHz, so this is not a sensible
> default.

How many of such chips are there and how many of the chips can do 400kHz ? I 
believe the majority shouldn't suffer because of minority.

[...]

Best regards,
Marek Vasut
