From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 10 Feb 2014 08:29:39 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSF0gQVJNOiBkdHM6IGkuTVg1MSBiYWJiYWdlOiBTdXBwb3J0?=
 =?UTF-8?B?IGRpYWdub3N0aWMgTEVE?=
In-Reply-To: <20140210030214.GB9628@S2101-09.ap.freescale.net>
References: <1391522263-17877-1-git-send-email-Ying.Liu@freescale.com>
 <20140210030214.GB9628@S2101-09.ap.freescale.net>
Message-ID: <1392006579.703394606@f357.i.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

???????????, 10 ??????? 2014, 11:02 +08:00 ?? Shawn Guo <shawn.guo@linaro.org>:
> On Tue, Feb 04, 2014 at 09:57:42PM +0800, Liu Ying wrote:
> > The D25 LED controlled by gpio on the i.MX51 babbage
> > board is a diagnostic LED according to the board design.
> > This patch adds the relevant device tree nodes to the
> > i.MX51 babbage device tree file to support this LED.
> > 
> > Signed-off-by: Liu Ying <Ying.Liu@freescale.com>
> > ---
> >  arch/arm/boot/dts/imx51-babbage.dts |   17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/imx51-babbage.dts
> b/arch/arm/boot/dts/imx51-babbage.dts
> > index be1407c..8d6a74b 100644
> > --- a/arch/arm/boot/dts/imx51-babbage.dts
> > +++ b/arch/arm/boot/dts/imx51-babbage.dts
> > @@ -81,6 +81,17 @@
> >  		};
> >  	};
> >  
> > +	leds {
> > +		compatible = "gpio-leds";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&led_pin_gpio2_6>;
> > +
> > +		led-diagnostic {
> > +			label = "diagnostic";
> > +			gpios = <&gpio2 6 0>;
> 
> Just out of curiosity, how will you use/trigger the led?

And GPIO bindings should be used to specify active level,
GPIO_ACTIVE_HIGH in this case.

---
