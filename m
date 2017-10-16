From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 16 Oct 2017 11:03:56 +0200
Subject: interrupts-extended only allowed with different parents? [Was: Re:
 [PATCH 3/4] ARM: dts: imx28-tx28: fix interrupt flags and use
 interrupts-extended property]
In-Reply-To: <20171016105632.709e653c@karo-electronics.de>
References: <1507719939-27250-1-git-send-email-LW@KARO-electronics.de>
 <1507719939-27250-4-git-send-email-LW@KARO-electronics.de>
 <20171016071726.gyzvalxzk4o3jsuz@pengutronix.de>
 <20171016105632.709e653c@karo-electronics.de>
Message-ID: <20171016090356.yvg5omwl4i75viiw@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 16, 2017 at 10:56:32AM +0200, Lothar Wa?mann wrote:
> Hi,
> 
> On Mon, 16 Oct 2017 09:17:26 +0200 Uwe Kleine-K?nig wrote:
> > Hello,
> > 
> > On Wed, Oct 11, 2017 at 01:05:38PM +0200, Lothar Wa?mann wrote:
> > > diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> > > index 211e67d..3c852f7 100644
> > > --- a/arch/arm/boot/dts/imx28-tx28.dts
> > > +++ b/arch/arm/boot/dts/imx28-tx28.dts
> > > @@ -328,8 +328,7 @@
> > >  		reg = <0x20>;
> > >  		pinctrl-names = "default";
> > >  		pinctrl-0 = <&tx28_pca9554_pins>;
> > > -		interrupt-parent = <&gpio3>;
> > > -		interrupts = <28 0>;
> > > +		interrupts-extended = <&gpio3 28 IRQ_TYPE_NONE>;
> > >  		gpio-controller;
> > >  		#gpio-cells = <2>;
> > >  		interrupt-controller;
> > 
> > While interrupts-extended looks nice,
> > Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
> > has:
> > 
> > 	"interrupts-extended" should only be used when a device has
> > 	multiple interrupt parents.
> > 
> > If this is still true, this patch is wrong.
> >
> Thanks for the hint. It really helps to read the documentation
> sometimes, rahter than relying on existing code only...
> 
> A quick check shows, that more than 100 of the 130 uses of
> interrupts-extended are wrong. :(

That's why I honestly consider that these documentation bits are stale.
I adapted the Subject to maybe catch the attention of the devicetree
guys.

(BTW: The current wording is likely imprecise. I'd expect that it really
should mean "Use interrupt-parent + interrupts if possible", but the
following still fulfills the documented condition:

	interrupts-extended = <&gpio3 28 IRQ_TYPE_NONE &gpio3 29 IRQ_TYPE_NONE>

while it can be expressed without interrupts-extended.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
