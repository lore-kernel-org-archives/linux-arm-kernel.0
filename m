From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 8 Mar 2017 09:31:44 -0800
Subject: [PATCH 1/2] ARM: dts: BCM53573: Don't use nonexistent
 "default-off" LED trigger
In-Reply-To: <20170308064105.26619-1-zajec5@gmail.com>
References: <20170308064105.26619-1-zajec5@gmail.com>
Message-ID: <42bce8ea-f1dc-2018-33f1-d296ccd7b677@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/07/2017 10:41 PM, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Such a trigger doesn't exist in Linux and is not needed as LED is being
> turned off by default. This could cause errors in LEDs core code when
> trying to set default trigger.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>

Since you are fixing something, what's the proper Fixes: tag for this
commit? Likewise for the second patch.

Thanks

> ---
>  arch/arm/boot/dts/bcm47189-tenda-ac9.dts | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
> index 6bdd79567cbd..34417dac1cd0 100644
> --- a/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
> +++ b/arch/arm/boot/dts/bcm47189-tenda-ac9.dts
> @@ -26,19 +26,16 @@
>  		usb {
>  			label = "bcm53xx:blue:usb";
>  			gpios = <&chipcommon 1 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "default-off";
>  		};
>  
>  		wps {
>  			label = "bcm53xx:blue:wps";
>  			gpios = <&chipcommon 10 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "default-off";
>  		};
>  
>  		5ghz {
>  			label = "bcm53xx:blue:5ghz";
>  			gpios = <&chipcommon 11 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "default-off";
>  		};
>  
>  		system {
> @@ -54,7 +51,6 @@
>  		2ghz {
>  			label = "bcm53xx:blue:2ghz";
>  			gpios = <&pcie0_chipcommon 3 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "default-off";
>  		};
>  	};
>  
> 


-- 
Florian
