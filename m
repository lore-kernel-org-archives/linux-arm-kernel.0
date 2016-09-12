From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Mon, 12 Sep 2016 20:25:54 +0200 (CEST)
Subject: [PATCH v2 6/6] ARM: dts: bcm283x: add pinctrl group to &sdhci,
 drop pins from &gpio
In-Reply-To: <1473668576-22256-7-git-send-email-kraxel@redhat.com>
References: <1473668576-22256-1-git-send-email-kraxel@redhat.com>
 <1473668576-22256-7-git-send-email-kraxel@redhat.com>
Message-ID: <1935531346.83849.15854341-2f8e-4e20-95f4-e76f81e6fd56.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gerd,

> Gerd Hoffmann <kraxel@redhat.com> hat am 12. September 2016 um 10:22
> geschrieben:
> 
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  arch/arm/boot/dts/bcm2835-rpi.dtsi | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 8688204..3f0ce61 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -43,7 +43,7 @@
>  	};
>  
>  	alt3: alt3 {
> -		brcm,pins = <48 49 50 51 52 53>;
> +		brcm,pins = <>;

after dropping all pins from the group alt3 doesn't make sense anymore. I think
this should be removed completely.

>  		brcm,function = <BCM2835_FSEL_ALT3>;
>  	};
>  };
> @@ -67,6 +67,8 @@
>  };
>  
>  &sdhci {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&emmc_gpio48>;
>  	status = "okay";
>  	bus-width = <4>;
>  };
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-rpi-kernel mailing list
> linux-rpi-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel
