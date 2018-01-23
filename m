From: sean.wang@mediatek.com (Sean Wang)
Date: Tue, 23 Jan 2018 16:51:45 +0800
Subject: [PATCH] arm: dts: mt7623: enable all four available UARTs on
 bananapi-r2
In-Reply-To: <1514043318.30687.10.camel@mtkswgap22>
References: <b4e84a68da76c1ca538150a730777ff530c1db5a.1513922513.git.sean.wang@mediatek.com>
 <dc3c28c7-03c3-f1c6-39c1-b8df8be4fac3@gmail.com>
 <1514043318.30687.10.camel@mtkswgap22>
Message-ID: <1516697505.12197.30.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2017-12-23 at 23:35 +0800, Sean Wang wrote:
> On Sat, 2017-12-23 at 08:52 +0100, Matthias Brugger wrote:
> > 
> > On 12/22/2017 07:06 AM, sean.wang at mediatek.com wrote:
> > > From: Sean Wang <sean.wang@mediatek.com>
> > > 
> > > On bpi-r2 board, totally there're four uarts which we usually called
> > > uart[0-3] helpful to extend slow I/O devices. Among those ones, uart2 has
> > > dedicated pin slot which is used to conolse log. uart[0-1] appear at the
> > > 40-pins connector and uart3 has no pinout, but just has test points (TP47
> > > for TX and TP48 for RX, respectively) nearby uart2. Also, some missing
> > > pinctrl is being complemented for those devices.
> > > 
> > > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > > ---
> > >  arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts | 26 ++++++++++++++++++++++++--
> > >  1 file changed, 24 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > > index 7bf5aa2..64bf5db 100644
> > > --- a/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > > +++ b/arch/arm/boot/dts/mt7623n-bananapi-bpi-r2.dts
> > > @@ -409,6 +409,20 @@
> > >  				 <MT7623_PIN_82_UTXD1_FUNC_UTXD1>;
> > >  		};do you like it or quite want me to remove the uart3 node?
> > >  	};
> > > +
> > > +	uart2_pins_a: uart at 2 {
> > > +		pins_dat {
> > > +			pinmux = <MT7623_PIN_14_GPIO14_FUNC_URXD2>,
> > > +				 <MT7623_PIN_15_GPIO15_FUNC_UTXD2>;
> > > +		};
> > > +	};
> > > +
> > > +	uart3_pins_a: uart at 3 {
> > > +		pins_dat {
> > > +			pinmux = <MT7623_PIN_242_URTS2_FUNC_URTS2>,
> > > +				 <MT7623_PIN_243_UCTS2_FUNC_UTXD3>;
> > > +		};
> > > +	};
> > >  };
> > >  
> > >  &pwm {
> > > @@ -454,16 +468,24 @@
> > >  &uart0 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&uart0_pins_a>;
> > > -	status = "disabled";
> > > +	status = "okay";
> > >  };
> > >  
> > >  &uart1 {
> > >  	pinctrl-names = "default";
> > >  	pinctrl-0 = <&uart1_pins_a>;
> > > -	status = "disabled";
> > > +	status = "okay";
> > >  };
> > >  
> > >  &uart2 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart2_pins_a>;
> > > +	status = "okay";
> > > +};
> > > +
> > > +&uart3 {
> > > +	pinctrl-names = "default";
> > > +	pinctrl-0 = <&uart3_pins_a>;
> > >  	status = "okay";
> > >  };
> > >  
> > 
> > Why do we want to enable uart3 when there are only test points?
> > It is not very useful, or do I oversee something?
> > 

> I have been listening to the sound from potential users of bpi-r2 to
> understand what assistance I have to provide to them. Something could
> be seen through [1] in the forum to know they had been trying hard to
> explore all available UARTs from the SoC in the last weeks. The patch
> should be really useful for these people and for the extra soldering
> it shouldn't become a problem for these makers.
> 
> [1] http://forum.banana-pi.org/t/gpio-uart-not-the-debug-port/3748
> 
> 	Sean 
> 

Hi, Matthias

do you like it or quite want me to remove the uart3 node?

I can take it into account along with other pending dts changes in my
queue.

	Sean
> 
> > Regards,
> > Matthias
> > 
> 
