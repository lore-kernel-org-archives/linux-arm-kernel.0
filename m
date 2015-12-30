From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 30 Dec 2015 17:43:05 +0100
Subject: [PATCH] ARM: dts: rockchip: Adding LEDs handling via leds-gpio
 for the Radxa Rock2 Square
In-Reply-To: <CABgxDoLS+WKX+5YGGgHHzsnxHRF9iMqUDo7nmBm6YXD99J5GAA@mail.gmail.com>
References: <1451474219-1313-1-git-send-email-romain.perier@gmail.com>
 <3020768.zersTrE99c@diego>
 <CABgxDoLS+WKX+5YGGgHHzsnxHRF9iMqUDo7nmBm6YXD99J5GAA@mail.gmail.com>
Message-ID: <1737278.m4cbh3zLlq@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Mittwoch, 30. Dezember 2015, 17:07:54 schrieb Romain Perier:
> Hi all,
> 
> I agree with Sjoerd, that's more useful to keep these LEDs in sync
> with the default vendor behaviour than put their default state to off
> and ask the user to manipulate them explicitly... in the worst case,
> he can still change the default state from sysfs...
> 
> 2015-12-30 16:53 GMT+01:00 Heiko St?bner <heiko@sntech.de>:
> >> > even a oneliner is generally preferred, compared to no commit message
> >> > at all
> >> > ;-)
> 
> Well, lack of inspiration :P
> No, just kidding, I agree.
> 
> >> > > Signed-off-by: Romain Perier <romain.perier@gmail.com>
> >> > > ---
> >> > > 
> >> > >  arch/arm/boot/dts/rk3288-rock2-square.dts | 17 +++++++++++++++++
> >> > >  1 file changed, 17 insertions(+)
> >> > > 
> >> > > diff --git a/arch/arm/boot/dts/rk3288-rock2-square.dts
> >> > > b/arch/arm/boot/dts/rk3288-rock2-square.dts index c5453a0..a33020f
> >> > > 100644
> >> > > --- a/arch/arm/boot/dts/rk3288-rock2-square.dts
> >> > > +++ b/arch/arm/boot/dts/rk3288-rock2-square.dts
> >> > > @@ -56,6 +56,23 @@
> >> > > 
> >> > >           pinctrl-0 = <&ir_int>;
> >> > >   
> >> > >   };
> >> > > 
> >> > > + gpio-leds {
> >> > > +         compatible = "gpio-leds";
> >> > > +
> >> > > +         heartbeat {
> >> > > +                 gpios = <&gpio7 15 GPIO_ACTIVE_LOW>;
> >> > > +                 label = "rock2:green:heartbeat";
> >> > > +                 linux,default-trigger = "heartbeat";
> >> > > +         };
> >> > > +
> >> > > +         mmc {
> >> > > +                 gpios = <&gpio0 11 GPIO_ACTIVE_LOW>;
> >> > > +                 label = "rock2:blue:mmc";
> >> > > +                 linux,default-trigger = "mmc0";
> >> > > +         };
> >> > 
> >> > the rock2 core schematics seem to not list these leds at all
> >> > (especially when
> >> > looking at the gpio-side). But looking at the schematics my guess
> >> > would be
> >> > led_state1 and led_state2, so the naming should reflect that
> >> > (rock2:green:state1 ...).
> 
> I used the schematic and the vendor devicetree to retrieve these
> informations.
> > Anybody opposed to me adding the following commit message?
> > 
> > ----
> > Describe the two user-controllable LEDs on Rock2-square boards.
> > The default-triggers mimic the behaviour of the vendor-kernel to
> > keep functionalities in sync.
> > ----
> 
> +1
> Please do.
> 
> Do you want a v2 patch ? (the label of these leds is wrong)

yep, bringing everything together makes sense :-)


Heiko
