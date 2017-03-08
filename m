From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 8 Mar 2017 13:11:56 +0100
Subject: [PATCH v4 3/7] mmc: bcm2835: add sdhost controller to devicetree
In-Reply-To: <1488964751-22763-6-git-send-email-kraxel@redhat.com>
References: <1488964751-22763-1-git-send-email-kraxel@redhat.com>
 <1488964751-22763-6-git-send-email-kraxel@redhat.com>
Message-ID: <a0cc10b6-b03c-2b61-f31a-f266d39a0d80@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Am 08.03.2017 um 10:19 schrieb Gerd Hoffmann:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> Acked-by: Eric Anholt <eric@anholt.net>

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

> ---
>   arch/arm/boot/dts/bcm2835-rpi.dtsi |  6 ++++++
>   arch/arm/boot/dts/bcm283x.dtsi     | 10 ++++++++++
>   2 files changed, 16 insertions(+)
>
> diff --git a/arch/arm/boot/dts/bcm2835-rpi.dtsi b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> index 1e00a28..8b95832 100644
> --- a/arch/arm/boot/dts/bcm2835-rpi.dtsi
> +++ b/arch/arm/boot/dts/bcm2835-rpi.dtsi
> @@ -69,6 +69,12 @@
>   	bus-width = <4>;
>   };
>   
> +&sdhost {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&sdhost_gpio48>;
> +	bus-width = <4>;
> +};
> +
>   &pwm {
>   	pinctrl-names = "default";
>   	pinctrl-0 = <&pwm0_gpio40 &pwm1_gpio45>;
> diff --git a/arch/arm/boot/dts/bcm283x.dtsi b/arch/arm/boot/dts/bcm283x.dtsi
> index 9798bc9..19099a5 100644
> --- a/arch/arm/boot/dts/bcm283x.dtsi
> +++ b/arch/arm/boot/dts/bcm283x.dtsi
> @@ -350,6 +350,16 @@
>   			arm,primecell-periphid = <0x00241011>;
>   		};
>   
> +		sdhost: mmc at 7e202000 {
> +			compatible = "brcm,bcm2835-sdhost";
> +			reg = <0x7e202000 0x100>;
> +			interrupts = <2 24>;
> +			clocks = <&clocks BCM2835_CLOCK_VPU>;
> +			dmas = <&dma 13>;
> +			dma-names = "rx-tx";
> +			status = "disabled";
> +		};
> +
>   		i2s: i2s at 7e203000 {
>   			compatible = "brcm,bcm2835-i2s";
>   			reg = <0x7e203000 0x20>,
