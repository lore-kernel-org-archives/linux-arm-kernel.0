From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 12 May 2016 16:56:59 +0200 (CEST)
Subject: [PATCH 3/4] ARM: dts: bcm2835: add the bcm2835-sdram-controller
 to the dt
In-Reply-To: <1463056732-5607-4-git-send-email-kernel@martin.sperl.org>
References: <1463056732-5607-1-git-send-email-kernel@martin.sperl.org>
 <1463056732-5607-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <73859954.21004.36a104a6-5284-487f-b397-da7ff0407f1f.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

> kernel at martin.sperl.org hat am 12. Mai 2016 um 14:38 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add the bcm2835 sdram controller to the device tree.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> ---
>  arch/arm/boot/dts/bcm283x.dtsi | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 8aaf193..9db9d97 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -22,6 +22,12 @@
>  		#address-cells = <1>;
>  		#size-cells = <1>;
>  
> +		memory-controller at 7e002000 {
> +			compatible = "brcm,bcm2835-sdram";
> +			reg = <0x7e002000 0x58>, <0x7e002800 0x58>;

where do you get these addresses?

According to register documentation [1] the adresses belong to the interrupt
controller.

Maybe 0x7ee00000 is the right address.

[1] - https://github.com/hermanhermitage/videocoreiv/wiki/Register-Documentation

> +			clocks = <&clocks BCM2835_CLOCK_SDRAM>;
> +		};
> +
>  		timer at 7e003000 {
>  			compatible = "brcm,bcm2835-system-timer";
>  			reg = <0x7e003000 0x1000>;
> -- 
> 2.1.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
