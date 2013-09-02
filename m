From: B47053@freescale.com (Xiubo Li-B47053)
Date: Mon, 2 Sep 2013 02:38:53 +0000
Subject: [PATCHv2 4/4] Documentation: Add device tree bindings for
 Freescale FTM PWM.
In-Reply-To: <20130830173008.GC30069@pengutronix.de>
References: <1377856132-11290-1-git-send-email-Li.Xiubo@freescale.com>
 <1377856132-11290-5-git-send-email-Li.Xiubo@freescale.com>
 <20130830173008.GC30069@pengutronix.de>
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F827F7831@039-SN2MPN1-011.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Subject: Re: [PATCHv2 4/4] Documentation: Add device tree bindings for
> Freescale FTM PWM.
> 
...
> > +
> > +pwm0: pwm at 40038000 {
> > +		compatible = "fsl,vf610-ftm-pwm";
> > +		reg = <0x40038000 0x1000>;
> > +		#pwm-cells = <3>;
> > +		clock-names = "ftm0", "ftm0_fix_sel", "ftm0_ext_sel";
> > +		clocks = <&clks VF610_CLK_FTM0>,
> > +			<&clks VF610_CLK_FTM0_FIX_SEL>,
> > +			<&clks VF610_CLK_FTM0_EXT_SEL>;
> > +		pinctrl-names = "ch0-active", "ch0-idle", "ch1-active", "ch1-
> idle",
> > +		....;
> > +		pinctrl-0 = <&pinctrl_pwm0_ch0_active>;
> > +		pinctrl-1 = <&pinctrl_pwm0_ch0_idle>;
> > +		pinctrl-2 = <&pinctrl_pwm0_ch1_active>;
> > +		pinctrl-3 = <&pinctrl_pwm0_ch1_idle>;
> > +		...
> > +		fsl,pwm-counter-clk = "ftm0_ext_sel";
> > +		fsl,pwm-avaliable-chs = <0 3 5 6>;
> 
> I don't think this proerty is useful. Just enable all channels. I think
> this was mentioned before.
> 
Yes.
Actully this property is located in board level dts file.
I have added and requested all the channels in SoC level dtsi file, and in board level dts file to tell the customer the limitation, I think is much safter and better.

--
Best Regards.
Xiubo
