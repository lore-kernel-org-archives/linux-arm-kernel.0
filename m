From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 26 Aug 2012 13:42:34 +0200
Subject: [PATCH 3/4 V2] ARM: mxs: Update DENX M28 machine and dts file
In-Reply-To: <20120825080504.GL31998@S2101-09.ap.freescale.net>
References: <1345852300-2213-1-git-send-email-marex@denx.de>
 <1345852300-2213-3-git-send-email-marex@denx.de>
 <20120825080504.GL31998@S2101-09.ap.freescale.net>
Message-ID: <201208261342.34653.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Shawn Guo,

> On Sat, Aug 25, 2012 at 01:51:39AM +0200, Marek Vasut wrote:
> > +
> > +		reg_vddio_sd0: vddio-sd0 {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "vddio-sd0";
> > +			regulator-min-microvolt = <3300000>;
> > +			regulator-max-microvolt = <3300000>;
> > +			gpio = <&gpio3 28 0>;
> > +		};
> > +
> > +		reg_usb0_vbus: usb0_vbus {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "usb0_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			gpio = <&gpio3 12 0>;
> > +			enable-active-low;
> 
> Documentation/devicetree/bindings/regulator/fixed-regulator.txt:
> 
> - enable-active-high: Polarity of GPIO is Active high
> If this property is missing, the default assumed is Active low.
> 
> I suspect you need to recheck this aspect for all these 3 fixed
> regulators.

Ok, so the prop had no impact? I'll retest and resubmit. Also, put the SPS1 on 
hold until the led issue is done for.

Thanks

> > +		};
> > +
> > +		reg_usb1_vbus: usb1_vbus {
> > +			compatible = "regulator-fixed";
> > +			regulator-name = "usb1_vbus";
> > +			regulator-min-microvolt = <5000000>;
> > +			regulator-max-microvolt = <5000000>;
> > +			gpio = <&gpio3 13 0>;
> > +			enable-active-low;
> > +		};

Best regards,
Marek Vasut
