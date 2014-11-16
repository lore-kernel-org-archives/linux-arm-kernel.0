From: afaerber@suse.de (=?windows-1252?Q?Andreas_F=E4rber?=)
Date: Sun, 16 Nov 2014 11:09:51 +0100
Subject: [RFC] adp1653: Add device tree bindings for LED controller
In-Reply-To: <20141116075928.GA9763@amd>
References: <20141116075928.GA9763@amd>
Message-ID: <546877EF.8010906@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pavel,

Am 16.11.2014 um 08:59 schrieb Pavel Machek:
> For device tree people: Yes, I know I'll have to create file in
> documentation, but does the binding below look acceptable?
[...]
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 739fcf2..ed0bfc1 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -553,6 +561,18 @@
>  
>  		ti,usb-charger-detection = <&isp1704>;
>  	};
> +
> +	adp1653: adp1653 at 30 {

This should probably be led-controller at 30 (a generic description not
specific to the model). The label name is fine.

> +		compatible = "ad,adp1653";
> +		reg = <0x30>;
> +
> +		max-flash-timeout-usec = <500000>;
> +		max-flash-intensity-uA    = <320000>;
> +		max-torch-intensity-uA     = <50000>;
> +		max-indicator-intensity-uA = <17500>;
> +
> +		gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* Want 88 */

At least to me, the meaning of "Want 88" is not clear - drop or clarify?

> +	};
>  };
>  
>  &i2c3 {
[snip]

Regards,
Andreas

-- 
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 21284 AG N?rnberg
