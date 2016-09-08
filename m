From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 8 Sep 2016 22:03:38 +0800
Subject: [PATCH v2 4/4] ARM: dts: imx28: Fix build warnings with W=1
In-Reply-To: <1473103670-15922-4-git-send-email-festevam@gmail.com>
References: <1473103670-15922-1-git-send-email-festevam@gmail.com>
 <1473103670-15922-4-git-send-email-festevam@gmail.com>
Message-ID: <20160908140338.GD16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 05, 2016 at 04:27:50PM -0300, Fabio Estevam wrote:
> diff --git a/arch/arm/boot/dts/imx28-tx28.dts b/arch/arm/boot/dts/imx28-tx28.dts
> index 0ebbc83..b4d4dbb 100644
> --- a/arch/arm/boot/dts/imx28-tx28.dts
> +++ b/arch/arm/boot/dts/imx28-tx28.dts
> @@ -35,7 +35,8 @@
>  		usbotg = &usb0;
>  	};
>  
> -	memory {
> +	memory at 0 {
> +		device_type = "memory";
>  		reg = <0 0>; /* will be filled in by U-Boot */

I'm curious to know if the unit-address will be fixed up or not when
'reg' property gets updated by U-Boot.

Shawn

>  	};
>  
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
