From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 12 Jul 2012 09:45:10 +0800
Subject: [PATCH v6 6/7] ARM: dts: imx28-evk: add usb devices
In-Reply-To: <1342006425-21008-7-git-send-email-richard.zhao@freescale.com>
References: <1342006425-21008-1-git-send-email-richard.zhao@freescale.com>
 <1342006425-21008-7-git-send-email-richard.zhao@freescale.com>
Message-ID: <20120712014508.GE6971@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 11, 2012 at 07:33:44PM +0800, Richard Zhao wrote:
> @@ -185,6 +203,24 @@
>  			regulator-max-microvolt = <3300000>;
>  			gpio = <&gpio2 15 0>;
>  		};
> +
> +		reg_usb0_vbus: usb0_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb0_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 9 0>;

Since we haven't got gpio API calling pinctrl to configure the pin
into gpio mode automatically, we need to set it it with pinctrl "hog"
node.  This is the same thing you have done with imx6q.

> +			enable-active-high;
> +		};
> +
> +		reg_usb1_vbus: usb1_vbus {
> +			compatible = "regulator-fixed";
> +			regulator-name = "usb1_vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio3 8 0>;

Ditto

> +			enable-active-high;
> +		};
>  	};

-- 
Regards,
Shawn
