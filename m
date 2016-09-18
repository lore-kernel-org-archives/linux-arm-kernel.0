From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 18 Sep 2016 13:41:21 +0200 (CEST)
Subject: [PATCH V5 3/6] ARM: bcm2835: dts: add thermal node to
 device-tree of bcm283x
In-Reply-To: <1473759262-27031-4-git-send-email-kernel@martin.sperl.org>
References: <1473759262-27031-1-git-send-email-kernel@martin.sperl.org>
 <1473759262-27031-4-git-send-email-kernel@martin.sperl.org>
Message-ID: <1012084044.209348.6508fbdb-00c5-486b-a34e-3d60ae68fe88.open-xchange@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> kernel at martin.sperl.org hat am 13. September 2016 um 11:34 geschrieben:
> 
> 
> From: Martin Sperl <kernel@martin.sperl.org>
> 
> Add the node for the thermal sensor of the bcm2835-soc
> to the device tree.
> 
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
> 
> Changelog:
> V1 -> V5: generic settings is shared in bcm283x.dtsi, but disabled
> 	  moved the compatible string to the SOC specific dtsi
>             for arm and arm64
> 
> Note: there is no arm/boot/dts/bcm2837.dtsi as of now,
>       so there is no support for bcm2837 in 32 bit mode.
> ---
>  arch/arm/boot/dts/bcm2835.dtsi | 6 ++++++
>  arch/arm/boot/dts/bcm2836.dtsi | 6 ++++++
>  arch/arm/boot/dts/bcm283x.dtsi | 7 +++++++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/bcm2835.dtsi b/arch/arm/boot/dts/bcm2835.dtsi
> index a78759e..0890d97 100644
> --- a/arch/arm/boot/dts/bcm2835.dtsi
> +++ b/arch/arm/boot/dts/bcm2835.dtsi
> @@ -23,3 +23,9 @@
>  		};
>  	};
>  };
> +
> +/* enable thermal sensor with the correct compatible property set */
> +&thermal {
> +	compatible = "brcm,bcm2835-thermal";
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/bcm2836.dtsi b/arch/arm/boot/dts/bcm2836.dtsi
> index 9d0651d..519a44f 100644
> --- a/arch/arm/boot/dts/bcm2836.dtsi
> +++ b/arch/arm/boot/dts/bcm2836.dtsi
> @@ -76,3 +76,9 @@
>  	interrupt-parent = <&local_intc>;
>  	interrupts = <8>;
>  };
> +
> +/* enable thermal sensor with the correct compatible property set */
> +&thermal {
> +	compatible = "brcm,bcm2836-thermal";
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index b982522..2cc4847 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -186,6 +186,13 @@
>  			interrupts = <2 14>; /* pwa1 */
>  		};
> 
> +		thermal: thermal at 0x7e212000 {

After removing 0x here like in the binding doc you can add:

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

> +			compatible = "brcm,bcm2835-thermal";
> +			reg = <0x7e212000 0x8>;
> +			clocks = <&clocks BCM2835_CLOCK_TSENS>;
> +			status = "disabled";
> +		};
> +
>  		aux: aux at 0x7e215000 {
>  			compatible = "brcm,bcm2835-aux";
>  			#clock-cells = <1>;
> --
> 2.1.4
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
