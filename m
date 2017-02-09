From: tony@atomide.com (Tony Lindgren)
Date: Thu, 9 Feb 2017 09:31:33 -0800
Subject: [PATCH v2 1/3] ARM: dts: Add support for phyCORE-AM335x PCM-953
 carrier board
In-Reply-To: <ff34a257-7272-9b9e-c0bb-a88bac8b3d05@arm.com>
References: <1485252576-36955-1-git-send-email-t.remmet@phytec.de>
 <ff34a257-7272-9b9e-c0bb-a88bac8b3d05@arm.com>
Message-ID: <20170209173132.GD21809@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sudeep Holla <sudeep.holla@arm.com> [170209 08:57]:
> On 24/01/17 10:09, Teresa Remmet wrote:
> > +	user_buttons: user_buttons {
> > +		compatible = "gpio-keys";
> > +		pinctrl-names = "default";
> > +		pinctrl-0 = <&user_buttons_pins>;
> > +
> > +		button at 0 {
> > +			label = "home";
> > +			linux,code = <KEY_HOME>;
> > +			gpios = <&gpio3 7 GPIO_ACTIVE_HIGH>;
> > +			gpio-key,wakeup;
> > +		};
> > +
> > +		button at 1 {
> > +			label = "menu";
> > +			linux,code = <KEY_MENU>;
> > +			gpios = <&gpio3 8 GPIO_ACTIVE_HIGH>;
> > +			gpio-key,wakeup;
> 
> Could you please replace this with wakeup-source as specified in
> Documentation/devicetree/bindings/power/wakeup-source.txt
> 
> I know this patch is merged, just fix it on top of linux-next ?
> I think TI/OMAP downstream tree has some remnants of the legacy
> boolean and it keeps slipping through every merge window :)

Oops sorry these keep coming. Teresa, can you please send a
follow-up fix against current Linux next?

Regards,

Tony
