From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 5 Feb 2013 09:03:58 +0800
Subject: [PATCH 1/2] ARM: dts: add support for some modules in imx6q
 sabresd
In-Reply-To: <8D894AC610DA3944965280D4097EAC4603CD30B8@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1359701198-23900-1-git-send-email-b13634@freescale.com>
 <20130203105830.GC26233@S2101-09.ap.freescale.net>
 <8D894AC610DA3944965280D4097EAC4603CD30B8@039-SN2MPN1-021.039d.mgd.msft.net>
Message-ID: <20130205010355.GA10807@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 04, 2013 at 09:19:10AM +0000, Zhang Quan-B13634 wrote:
> >  > +			i2c at 021a0000 { /* I2C1 */
> >  > +				status = "okay";
> >  > +				clock-frequency = <100000>;
> >  > +				pinctrl-names = "default";
> >  > +				pinctrl-0 = <&pinctrl_i2c1_2>;
> >  > +
> >  > +				codec: wm8962 at 1a {
> >  > +					compatible = "fsl,wm8962";
> >  
> >  This does not seem right, as wm8962 is not a codec produced by FSL.
> >  I suspect you can have your driver work even without this compatible since it's
> >  a I2C device.  If so, you can choose to simply drop it.
> >  
> >  Shawn
> [Gary-b13634] this should be changed to "wlf, wm8962"; but it can't be dropped,
> Or else codec driver will be failed to load.

Ah, sorry.  I forgot that modalias needs to come from the compatible
string. Yes, "wlf,wm8962" (no space after comma) should be the right
one.

Shawn
