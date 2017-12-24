From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 24 Dec 2017 23:00:46 +0100 (CET)
Subject: [PATCH] BCM283x JTAG pins on ALT5 Function
In-Reply-To: <1514150282-9988-1-git-send-email-henryzhang62@gmail.com>
References: <1514150282-9988-1-git-send-email-henryzhang62@gmail.com>
Message-ID: <1247477669.275926.1514152846080@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Henry,

> henryzhang62 at gmail.com hat am 24. Dezember 2017 um 22:18 geschrieben:
> 
> 
> From: Henry Zhang <henryzhang62@gmail.com>
> 
> BCM2835 ARM Peripherals doc shows gpio pins 4, 5, 6, 12 and 13
> carry altenate function, ALT5 for ARM JTAG
> 
> Signed-off-by: Henry Zhang <henryzhang62@gmail.com>

thanks for this patch, but it needs some minor improvements in a second version. First of all please send a copy to Eric Anholt and linux-rpi-kernel at lists.infradead.org (moderated list) as reported by get_maintainer.pl.

The subject of your patch needs adjustment. Here is my suggestion:
ARM: dts: bcm283x: Fix pin function of JTAG pins

Also please add a proper fixes tag like:
Fixes: 21ff843931b2 ("ARM: dts: bcm283x: Define standard pinctrl groups in the gpio node.")

After that you can have my
Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index dcde93c..64971e4 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -251,7 +251,7 @@
>  
>  			jtag_gpio4: jtag_gpio4 {
>  				brcm,pins = <4 5 6 12 13>;
> -				brcm,function = <BCM2835_FSEL_ALT4>;
> +				brcm,function = <BCM2835_FSEL_ALT5>;
>  			};
>  			jtag_gpio22: jtag_gpio22 {
>  				brcm,pins = <22 23 24 25 26 27>;
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
