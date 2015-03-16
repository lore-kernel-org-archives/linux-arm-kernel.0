From: tony@atomide.com (Tony Lindgren)
Date: Mon, 16 Mar 2015 14:04:39 -0700
Subject: [PATCH v4 4/6] ARM: dts: omap3-gta04: Add battery support
In-Reply-To: <20150316205341.GD12397@atomide.com>
References: <1426022847-30912-1-git-send-email-marek@goldelico.com>
 <1426022847-30912-5-git-send-email-marek@goldelico.com>
 <20150316205341.GD12397@atomide.com>
Message-ID: <20150316210439.GG12397@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tony Lindgren <tony@atomide.com> [150316 13:59]:
> * Marek Belisko <marek@goldelico.com> [150310 14:28]:
> > Added battery support for gta04 devices.
> > 
> > Signed-off-by: Marek Belisko <marek@goldelico.com>
> 
> Picking up this patch into omap-for-v4.1/dt branch thanks.

Actually not yet applying this as looks like Pavel just
had few comments on these properties.
 
> Tony
> 
> > ---
> >  arch/arm/boot/dts/omap3-gta04.dtsi | 30 ++++++++++++++++++++++++++++++
> >  1 file changed, 30 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> > index fb3a696..cbf515a 100644
> > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > @@ -49,6 +49,32 @@
> >  		ti,codec = <&twl_audio>;
> >  	};
> >  
> > +	battery {
> > +		compatible = "ti,twl4030-madc-battery";
> > +		capacity-uah = <1200000>;
> > +		ti,volt-to-capacity-charging-map = <4200 100>,
> > +					     <4100 75>,
> > +					     <4000 55>,
> > +					     <3900 25>,
> > +					     <3800 5>,
> > +					     <3700 2>,
> > +					     <3600 1>,
> > +					     <3300 0>;
> > +		ti,volt-to-capacity-discharging-map = <4200 100>,
> > +						<4100 95>,
> > +						<4000 70>,
> > +						<3800 50>,
> > +						<3700 10>,
> > +						<3600 5>,
> > +						<3300 0>;
> > +		io-channels = <&twl_madc 1>,
> > +	                      <&twl_madc 10>,
> > +			      <&twl_madc 12>;
> > +		io-channel-names = "temp",
> > +		                   "ichg",
> > +		                   "vbat";
> > +	};
> > +
> >  	spi_lcd {
> >  		compatible = "spi-gpio";
> >  		#address-cells = <0x1>;
> > @@ -518,3 +544,7 @@
> >  &mcbsp2 {
> >  	status = "okay";
> >  };
> > +
> > +&twl_madc {
> > +	ti,system-uses-second-madc-irq;
> > +};
> > -- 
> > 1.9.1
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
