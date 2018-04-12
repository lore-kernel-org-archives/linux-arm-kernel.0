From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 12 Apr 2018 16:51:36 +0200
Subject: [PATCH 3/3] ARM: dts: sun7i: Add support for the Ainol AW1 tablet
In-Reply-To: <7f6d6a6a5a0cc2d37ebba046509d4f25d3bfa600.camel@paulk.fr>
References: <20180410213129.24049-1-contact@paulk.fr>
 <20180410213129.24049-3-contact@paulk.fr>
 <20180411070657.kw6uckqtmwb7p5hf@flea>
 <7f6d6a6a5a0cc2d37ebba046509d4f25d3bfa600.camel@paulk.fr>
Message-ID: <20180412145136.zp2i7u76oinphiiz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 01:08:51AM +0200, Paul Kocialkowski wrote:
> > > +	backlight: backlight {
> > > +		compatible = "pwm-backlight";
> > > +		pinctrl-names = "default";
> > > +		pinctrl-0 = <&backlight_enable_pin>;
> > 
> > You don't need any of the pinctrl nodes for the GPIOs
> 
> I tried without the pinctrl nodes and got issues on various controllers
> (e.g. i2c for the touchscreen) because of the missing pinctrl nodes on
> 4.16. Maybe I'm missing some patches here?

You don't need any patches. What was the error exactly?

> > > +&cpu0 {
> > > +	cpu-supply = <&reg_dcdc2>;
> > > +};
> > 
> > How was CPUfreq tested?
> 
> In fact, I haven't tried it at all, but I can definitely do that with
> e.g. ssvb's stress test for various cpufreq functioning points.

That would be great yes.

> > > +&i2c2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&i2c2_pins_a>;
> > > +	status = "okay";
> > > +	clock-frequency = <400000>; /* 400 KHz required for
> > > GSL1680. */
> > 
> > I'm not sure that comment is worth it. The only device there is the
> > touchscreen, so it's kind of obvious that it's the device that needs
> > that frequency.
> 
> Well, I found a similar comment in the other dts using the same
> touchscreen controller. Since the information was rather valuable (it
> made it clear that I needed the same clock frequency for that specific
> touchscreen),

You can have the same kind of comment for pretty much all DT
lines. you could for example have on the pinctrl property just above
the comment that the I2C2 on that boards are tied to those pins. But
that's just redundant, and the SNR would be pretty bad if we were to
do it everywhere.

> it might help others in the future (even if only when grepping for
> gsl1680).
> 
> > > +
> > > +	gsl1680: touchscreen at 40 {
> > > +		compatible = "silead,gsl1680";

You have the gsl1680 two times here, so grep would find it either way.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180412/8b948e5b/attachment.sig>
