From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 20 Sep 2018 14:41:47 +0200
Subject: [PATCH] ARM: dts: sun8i: sun8i-h3-nanopi-m1-plus: enable HDMI
 output
In-Reply-To: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
References: <1537388051-39623-1-git-send-email-clabbe@baylibre.com>
Message-ID: <20180920124147.u2f72ygfch5my5sa@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On Wed, Sep 19, 2018 at 08:14:11PM +0000, Corentin Labbe wrote:
> This patch enable HDMI output on sun8i-h3-nanopi-m1-plus.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
>  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> index 65cba1050802..88b5ff6b66b6 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> @@ -67,6 +67,21 @@
>  		pinctrl-names = "default";
>  		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
>  	};
> +
> +	connector {
> +		compatible = "hdmi-connector";
> +		type = "a";
> +
> +		port {
> +			hdmi_con_in: endpoint {
> +				remote-endpoint = <&hdmi_out_con>;
> +			};
> +		};
> +	};
> +};
> +
> +&de {
> +	status = "okay";
>  };
>  
>  &ehci1 {
> @@ -94,6 +109,17 @@
>  	};
>  };
>  
> +&hdmi {
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +	status = "okay";

you don't need that status property here

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180920/157cc3b1/attachment.sig>
