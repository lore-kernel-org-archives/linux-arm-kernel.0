From: jason@lakedaemon.net (Jason Cooper)
Date: Mon, 1 Jul 2013 17:24:49 -0400
Subject: [PATCH] arm: kirkwood: readynas duo v2: Add GMT G762 Fan
 Controller DT bindings
In-Reply-To: <87k3lauimd.fsf@natisbad.org>
References: <87sizyuj0t.fsf@natisbad.org> <20130701222814.36ca395a@skate>
 <87k3lauimd.fsf@natisbad.org>
Message-ID: <20130701212449.GE19937@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 10:31:54PM +0200, Arnaud Ebalard wrote:
> Hi Thomas,
> 
> Thomas Petazzoni <thomas.petazzoni@free-electrons.com> writes:
> 
> > On Mon, 01 Jul 2013 22:23:14 +0200, Arnaud Ebalard wrote:
> >
> >> -        regulators {
> >> -                compatible = "simple-bus";
> >> -                #address-cells = <1>;
> >> -                #size-cells = <0>;
> >> -
> >> -                usb_power: regulator at 1 {
> >> -                        compatible = "regulator-fixed";
> >> -                        reg = <1>;
> >> -                        regulator-name = "USB 3.0 Power";
> >> -                        regulator-min-microvolt = <5000000>;
> >> -                        regulator-max-microvolt = <5000000>;
> >> -                        enable-active-high;
> >> -                        regulator-always-on;
> >> -                        regulator-boot-on;
> >> -                        gpio = <&gpio1 14 0>;
> >> -                };
> >> -        };
> >> +	regulators {
> >> +		compatible = "simple-bus";
> >> +		#address-cells = <1>;
> >> +		#size-cells = <0>;
> >> +
> >> +		usb_power: regulator at 1 {
> >> +			compatible = "regulator-fixed";
> >> +			reg = <1>;
> >> +			regulator-name = "USB 3.0 Power";
> >> +			regulator-min-microvolt = <5000000>;
> >> +			regulator-max-microvolt = <5000000>;
> >> +			enable-active-high;
> >> +			regulator-always-on;
> >> +			regulator-boot-on;
> >> +			gpio = <&gpio1 14 0>;
> >> +		};
> >> +	};
> >>  };
> >
> > Those white-space changes are not related to the addition of the G762
> > Device Tree informations.
> 
> Should I make two unrelated patches (one for G762 and another cosmetic
> one) or simply let the spaces as they are in .dts?

Leave them as they are.  I'm intending to do a cleanup series for all
the whitespace issues in the dts files.

thx,

Jason.
