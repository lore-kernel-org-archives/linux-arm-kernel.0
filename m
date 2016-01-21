From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Thu, 21 Jan 2016 10:12:41 +0100
Subject: [PATCH] ARM: dts: n900: Include adp1653 device
In-Reply-To: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
References: <1451086812-3729-1-git-send-email-pali.rohar@gmail.com>
Message-ID: <20160121091241.GS7192@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 December 2015 00:40:12 Pali Roh?r wrote:
> This patch adds adp1653 device into n900 DT structure. DT support in
> adp1653 driver is there since v4.2-rc1 version.
> 
> Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> ---
>  arch/arm/boot/dts/omap3-n900.dts |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
> index 5f5e0f3..ba93642 100644
> --- a/arch/arm/boot/dts/omap3-n900.dts
> +++ b/arch/arm/boot/dts/omap3-n900.dts
> @@ -522,6 +522,21 @@
>  		amstaos,cover-comp-gain = <16>;
>  	};
>  
> +	adp1653: led-controller at 30 {
> +		compatible = "adi,adp1653";
> +		reg = <0x30>;
> +		enable-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>; /* 88 */
> +
> +		flash {
> +			flash-timeout-us = <500000>;
> +			flash-max-microamp = <320000>;
> +			led-max-microamp = <50000>;
> +		};
> +		indicator {
> +			led-max-microamp = <17500>;
> +		};
> +	};
> +
>  	lp5523: lp5523 at 32 {
>  		compatible = "national,lp5523";
>  		reg = <0x32>;

PING, who can take this patch?

I still do not see it in linus tree nor in others like arm-soc...

-- 
Pali Roh?r
pali.rohar at gmail.com
