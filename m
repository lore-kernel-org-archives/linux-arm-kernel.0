From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 2 Aug 2018 12:55:35 +0200
Subject: [PATCH] fix vibrations on Droid 4
In-Reply-To: <20180801202821.GB4033@amd>
References: <20180709214910.tes6u4ivxomd3aja@earth.universe>
 <20180709220211.GA7760@amd>
 <20180710101147.lyu65ro4czvrs2da@earth.universe>
 <20180710133040.GA4391@amd>
 <20180710161123.azym6sbboriuj4yc@earth.universe>
 <20180711080218.GA21225@amd> <20180711132739.GL99251@atomide.com>
 <20180715201729.GB19675@amd> <20180716075926.GU99251@atomide.com>
 <20180801202821.GB4033@amd>
Message-ID: <20180802105535.2fvggxsma22usrfr@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Aug 01, 2018 at 10:28:21PM +0200, Pavel Machek wrote:
> Vibration GPIOs don't have anything to do with wakeup. Move it to
> normal section; this fixes vibrations on Droid 4.
>     
> Signed-off-by: Pavel Machek <pavel@ucw.cz>
> 
> diff --git a/arch/arm/boot/dts/omap4-droid4-xt894.dts b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> index c27fc87..7b82179 100644

Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>

-- Sebastian

> --- a/arch/arm/boot/dts/omap4-droid4-xt894.dts
> +++ b/arch/arm/boot/dts/omap4-droid4-xt894.dts
> @@ -646,15 +646,6 @@
>  		OMAP4_IOPAD(0x10c, PIN_INPUT | MUX_MODE1)	/* abe_mcbsp3_fsx */
>  		>;
>  	};
> -};
> -
> -&omap4_pmx_wkup {
> -	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
> -		/* gpio_wk0 */
> -		pinctrl-single,pins = <
> -		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
> -		>;
> -	};
>  
>  	vibrator_direction_pin: pinmux_vibrator_direction_pin {
>  		pinctrl-single,pins = <
> @@ -669,6 +660,15 @@
>  	};
>  };
>  
> +&omap4_pmx_wkup {
> +	usb_gpio_mux_sel2: pinmux_usb_gpio_mux_sel2_pins {
> +		/* gpio_wk0 */
> +		pinctrl-single,pins = <
> +		OMAP4_IOPAD(0x040, PIN_OUTPUT_PULLDOWN | MUX_MODE3)
> +		>;
> +	};
> +};
> +
>  /*
>   * As uart1 is wired to mdm6600 with rts and cts, we can use the cts pin for
>   * uart1 wakeirq.
> 
> -- 
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180802/77133ac5/attachment.sig>
