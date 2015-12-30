From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Dec 2015 16:53:51 +0100
Subject: [PATCH] ARM: dts: rockchip: Adding LEDs handling via leds-gpio
 for the Radxa Rock2 Square
In-Reply-To: <1451490343.11453.28.camel@collabora.co.uk>
References: <1451474219-1313-1-git-send-email-romain.perier@gmail.com>
 <3613784.8JLtyMHEE9@diego> <1451490343.11453.28.camel@collabora.co.uk>
Message-ID: <3020768.zersTrE99c@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 30. Dezember 2015, 16:45:43 schrieb Sjoerd Simons:
> On Wed, 2015-12-30 at 16:20 +0100, Heiko St?bner wrote:
> > Am Mittwoch, 30. Dezember 2015, 12:16:59 schrieb Romain Perier:
> > 
> > even a oneliner is generally preferred, compared to no commit message
> > at all 
> > ;-)
> > 
> > > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> > > ---
> > >  arch/arm/boot/dts/rk3288-rock2-square.dts | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > b/arch/arm/boot/dts/rk3288-rock2-square.dts index c5453a0..a33020f
> > > 100644
> > > --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> > > @@ -56,6 +56,23 @@
> > >  		pinctrl-0 = <&ir_int>;
> > >  	};
> > > 
> > > +	gpio-leds {
> > > +		compatible = "gpio-leds";
> > > +
> > > +		heartbeat {
> > > +			gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
> > > +			label = "rock2:green:heartbeat";
> > > +			linux,default-trigger = "heartbeat";
> > > +		};
> > > +
> > > +		mmc {
> > > +			gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
> > > +			label = "rock2:blue:mmc";
> > > +			linux,default-trigger = "mmc0";
> > > +		};
> > 
> > the rock2 core schematics seem to not list these leds at all
> > (especially when 
> > looking at the gpio-side). But looking at the schematics my guess
> > would be 
> > led_state1 and led_state2, so the naming should reflect that 
> > (rock2:green:state1 ...).
> > 
> > Also I'd like to refrain from encoding user-specific configurations
> > in the 
> > devicetree - aka please do a default trigger of "off" for those
> > generic leds.
> 
> Seems a grey area. The vendor kernel configures these LEDs with the
> same default triggers as Romains patch does, so one could argue these
> are the intended usages for those LEDs (as such it's hardware
> description not use-specific configuration?). 
> 
> In any case having sensible default triggers (e.g. having the default
> mainline behaviour act the same as the vendor behaviour) seems quite a
> lot more useful then keeping these LEDs off and forcing usespace to set
> them up.

I only looked at the schematics, so missed that. While personally I'd still 
like having the "christmas-tree" off by default, Sjoerd's argument for the 
trigger-choice sounds sensible.
Hint for next time: Describing that makes a good commit message

Anybody opposed to me adding the following commit message?

----
Describe the two user-controllable LEDs on Rock2-square boards.
The default-triggers mimic the behaviour of the vendor-kernel to
keep functionalities in sync.
----


Heiko
