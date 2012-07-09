From: marex@denx.de (Marek Vasut)
Date: Mon, 9 Jul 2012 17:58:22 +0200
Subject: [PATCH 1/2 V2] MXS: Set I2C timing registers for mxs-i2c
In-Reply-To: <20120709120523.GG1296@pengutronix.de>
References: <1341554956-17416-1-git-send-email-marex@denx.de>
 <201207091307.35860.marex@denx.de> <20120709120523.GG1296@pengutronix.de>
Message-ID: <201207091758.22788.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Wolfram Sang,

> > > > diff --git a/arch/arm/boot/dts/imx28.dtsi
> > > > b/arch/arm/boot/dts/imx28.dtsi index ee3778a..832d30a 100644
> > > > --- a/arch/arm/boot/dts/imx28.dtsi
> > > > +++ b/arch/arm/boot/dts/imx28.dtsi
> > 
> > [...]
> > 
> > > > @@ -428,6 +429,7 @@
> > > > 
> > > >  				compatible = "fsl,imx28-i2c";
> > > >  				reg = <0x8005a000 2000>;
> > > >  				interrupts = <110 69>;
> > > > 
> > > > +				clock-frequency = <400000>;
> > > 
> > > NACK on that. Not all slaves can do 400KHz, so this is not a sensible
> > > default.
> > 
> > How many of such chips are there and how many of the chips can do 400kHz
> > ? I believe the majority shouldn't suffer because of minority.
> 
> The kernel should work for all users, not only for the majority, so:
> Better safe than sorry.
> 
> Also, defaults should make the system work. Tuning can be done later by
> somebody who understands what is needed.
> 
> And frankly, this attitude which made you add a potential regression is
> worrisome. I'd suggest to give stability a higher priority.

I believe you misunderstood my intention. Setting it to 400kHz was done because 
it's what most people will use, therefore avoiding duplication (most of the 
board files will override this setting now). All right, your sane defaults here 
can be applied, I won't argue.

And frankly, you could have left the last jab out. Let's avoid attacking each 
other, I'm not in the mood for it today.

> Regards,
> 
>    Wolfram

Best regards,
Marek Vasut
