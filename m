From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Tue, 11 Oct 2016 10:01:39 +0200
Subject: [PATCH] n900 device tree: cleanup, add camera flash
In-Reply-To: <20161011075416.GA22453@amd>
References: <20161011075416.GA22453@amd>
Message-ID: <20161011080139.GK4467@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 11 October 2016 09:54:17 Pavel Machek wrote:
> @@ -669,6 +670,22 @@
>  
>  		ti,usb-charger-detection = <&isp1707>;
>  	};
> +
> +	adp1653: led-controller at 30 {
> +		compatible = "adi,adp1653";
> +		reg = <0x30>;
> +		gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> +
> +		flash {
> +			flash-timeout-us = <500000>;
> +			flash-max-microamp = <320000>;
> +			max-microamp = <50000>;
> +		};
> +
> +		indicator {
> +			max-microamp = <17500>;
> +		};
> +	};
>  };
>  
>  &i2c3 {
> 

This part of patch is already in mainline kernel, isn't?

-- 
Pali Roh?r
pali.rohar at gmail.com
