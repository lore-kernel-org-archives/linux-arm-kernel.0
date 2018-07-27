From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 27 Jul 2018 14:56:15 +0200
Subject: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI
 output on A64 boards w/ HDMI
In-Reply-To: <20180726171257.6688-11-icenowy@aosc.io>
References: <20180726171257.6688-1-icenowy@aosc.io>
 <20180726171257.6688-11-icenowy@aosc.io>
Message-ID: <20180727125615.ju23ecgm6y4rz7p5@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 1b9b92e541d2..1b972bade9f6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -62,6 +62,21 @@
>  	chosen {
>  		stdout-path = "serial0:115200n8";
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
>  &ehci0 {
> @@ -82,6 +97,17 @@
>  
>  };
>  
> +&hdmi {
> +	hdmi-supply = <&reg_dldo1>;
> +	status = "okay";
> +};
> +
> +&hdmi_out {
> +	hdmi_out_con: endpoint {
> +		remote-endpoint = <&hdmi_con_in>;
> +	};
> +};
> +
>  &i2c1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c1_pins>;
> @@ -99,6 +125,10 @@
>  	};
>  };
>  
> +&mixer1 {
> +	status = "okay";
> +};
> +
>  &mmc0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mmc0_pins>;
> @@ -238,6 +268,10 @@
>  	status = "disabled";
>  };
>  
> +&tcon1 {
> +	status = "okay";
> +};

Is it working or not on the pine64?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180727/9441978f/attachment.sig>
