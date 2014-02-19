From: elder@linaro.org (Alex Elder)
Date: Wed, 19 Feb 2014 15:21:29 -0600
Subject: [PATCH] ARM: dts: remove bcm11351-brt.dts
In-Reply-To: <1392840808-28214-1-git-send-email-mporter@linaro.org>
References: <1392840808-28214-1-git-send-email-mporter@linaro.org>
Message-ID: <53052059.3020105@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/19/2014 02:13 PM, Matt Porter wrote:
> The BCM11351 BRT board will never see the light of day. Remove the BRT
> dts since it is not maintainable.
> 
> Signed-off-by: Matt Porter <mporter@linaro.org>

Please remove the line in the Makefile that refers to this file.
Provided you make that change, it looks good to me.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  arch/arm/boot/dts/bcm11351-brt.dts | 54 --------------------------------------
>  1 file changed, 54 deletions(-)
>  delete mode 100644 arch/arm/boot/dts/bcm11351-brt.dts
> 
> diff --git a/arch/arm/boot/dts/bcm11351-brt.dts b/arch/arm/boot/dts/bcm11351-brt.dts
> deleted file mode 100644
> index 396b704..0000000
> --- a/arch/arm/boot/dts/bcm11351-brt.dts
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -/*
> - * Copyright (C) 2012 Broadcom Corporation
> - *
> - * This program is free software; you can redistribute it and/or
> - * modify it under the terms of the GNU General Public License as
> - * published by the Free Software Foundation version 2.
> - *
> - * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> - * kind, whether express or implied; without even the implied warranty
> - * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - */
> -
> -/dts-v1/;
> -
> -#include "bcm11351.dtsi"
> -
> -/ {
> -	model = "BCM11351 BRT board";
> -	compatible = "brcm,bcm11351-brt", "brcm,bcm11351";
> -
> -	memory {
> -		reg = <0x80000000 0x40000000>; /* 1 GB */
> -	};
> -
> -	uart at 3e000000 {
> -		status = "okay";
> -	};
> -
> -	sdio1: sdio at 3f180000 {
> -		max-frequency = <48000000>;
> -		status = "okay";
> -	};
> -
> -	sdio2: sdio at 3f190000 {
> -		non-removable;
> -		max-frequency = <48000000>;
> -		status = "okay";
> -	};
> -
> -	sdio4: sdio at 3f1b0000 {
> -		max-frequency = <48000000>;
> -		cd-gpios = <&gpio 14 0>;
> -		status = "okay";
> -	};
> -
> -	usbotg: usb at 3f120000 {
> -		status = "okay";
> -	};
> -
> -	usbphy: usb-phy at 3f130000 {
> -		status = "okay";
> -	};
> -};
> 
