From: avinashphilip@ti.com (Philip, Avinash)
Date: Fri, 23 Nov 2012 10:35:01 +0000
Subject: [PATCH v4 10/11] ARM: dts: AM33XX: Add PWM backlight DT data to
 am335x-evm
In-Reply-To: <20121122211147.GI16716@avionic-0098.adnet.avionic-design.de>
References: <1353503469-18634-1-git-send-email-avinashphilip@ti.com>
 <1353503469-18634-11-git-send-email-avinashphilip@ti.com>
 <20121122211147.GI16716@avionic-0098.adnet.avionic-design.de>
Message-ID: <518397C60809E147AF5323E0420B992E3E9EE9AE@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 02:41:47, Thierry Reding wrote:
> On Wed, Nov 21, 2012 at 06:41:07PM +0530, Philip, Avinash wrote:
> [...]
> > diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
> > index 9f65f17..4178ba4 100644
> > --- a/arch/arm/boot/dts/am335x-evm.dts
> > +++ b/arch/arm/boot/dts/am335x-evm.dts
> > @@ -44,6 +44,12 @@
> >  				0x154 0x27	/* spi0_d0.gpio0_3, INPUT | MODE7 */
> >  			>;
> >  		};
> > +
> > +		ecap0_pins: backlight_pins {
> > +			pinctrl-single,pins = <
> > +				0x164 0x0	/* eCAP0_in_PWM0_out.eCAP0_in_PWM0_out MODE0 */
> > +			>;
> 
> This looks kind of funky, but I see the rest of the file uses similar
> formatting, so I guess it's okay.
> 
> > @@ -158,6 +174,13 @@
> >  			gpio-key,wakeup;
> >  		};
> >  	};
> > +
> > +	backlight {
> > +		compatible	= "pwm-backlight";
> 
> Maybe you don't want a tab between "compatible" and "=", but a space
> instead.

I will correct it.

Thanks
Avinash

> 
> Other than that, looks good:
> 
> Reviewed-by: Thierry Reding <thierry.reding@avionic-design.de>
> 
