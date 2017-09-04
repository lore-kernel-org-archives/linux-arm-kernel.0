From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 10:05:19 +0200
Subject: [PATCH v2 2/2] ARM: dts: sun8i: h3: Improved Wifi bindings on
 Bananapi M2 Plus
In-Reply-To: <1504283401-4263-3-git-send-email-embed3d@gmail.com>
References: <1504283401-4263-1-git-send-email-embed3d@gmail.com>
 <1504283401-4263-3-git-send-email-embed3d@gmail.com>
Message-ID: <20170904080519.mec6ypjei7uvo5k7@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Fri, Sep 01, 2017 at 06:30:01PM +0200, Philipp Rossak wrote:
> From: Philipp Rossak <embed3d@gmail.com>
> 
> * vqmmc is in this case not needed
> * no need for pincontrol nodes when the pin is set to a GPIO
> 
> Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 7 -------
>  1 file changed, 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> index d756ff8..f7e5d8a 100644
> --- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
> @@ -98,7 +98,6 @@
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		pinctrl-names = "default";
> -		pinctrl-0 = <&wifi_en_bpi_m2p>;
>  		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>  	};
>  };
> @@ -153,7 +152,6 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc1_pins_a>;
>  	vmmc-supply = <&reg_vcc3v3>;
> -	vqmmc-supply = <&reg_vcc3v3>;

So we actually need this one.

>  	mmc-pwrseq = <&wifi_pwrseq>;
>  	bus-width = <4>;
>  	non-removable;
> @@ -200,11 +198,6 @@
>  		pins = "PL3";
>  		function = "gpio_in";
>  	};
> -
> -	wifi_en_bpi_m2p: wifi_en_pin {
> -		pins = "PL7";
> -		function = "gpio_out";
> -	};

And there's also other GPIO pins here, I'd prefer if you could tackle
them all at once.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/fdf0632a/attachment.sig>
