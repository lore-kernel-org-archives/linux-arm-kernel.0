From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 15:38:34 +0800
Subject: [PATCH 4/4] ARM: dts: i.MX27 boards: Switch to use standard GPIO
 and IRQ flags definitions
In-Reply-To: <1385792284-22286-4-git-send-email-shc_work@mail.ru>
References: <1385792284-22286-1-git-send-email-shc_work@mail.ru>
 <1385792284-22286-4-git-send-email-shc_work@mail.ru>
Message-ID: <20131203073832.GF10840@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 30, 2013 at 10:18:04AM +0400, Alexander Shiyan wrote:
> diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> index 3145bdb..2cb9e4b 100644
> --- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> +++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
> @@ -16,7 +16,8 @@
>  
>  &cspi1 {
>  	fsl,spi-num-chipselects = <2>;
> -	cs-gpios = <&gpio4 28 0>, <&gpio4 27 0>;
> +	cs-gpios = <&gpio4 28 GPIO_ACTIVE_HIGH>,
> +		   <&gpio4 27 GPIO_ACTIVE_LOW>;

Shouldn't it also be GPIO_ACTIVE_HIGH?

Shawn

>  };
>  
>  &i2c1 {
