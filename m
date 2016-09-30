From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 30 Sep 2016 08:49:27 -0700
Subject: [PATCH] ARM64: dts: meson-gxbb-odroidc2: Enable USB Nodes
In-Reply-To: <1475227059-17462-1-git-send-email-brian.kim@hardkernel.com>
 (Brian Kim's message of "Fri, 30 Sep 2016 18:17:39 +0900")
References: <1475227059-17462-1-git-send-email-brian.kim@hardkernel.com>
Message-ID: <7h7f9tgzg8.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Brian Kim <brian.kim@hardkernel.com> writes:

> Enable both gxbb USB controller and add a 5V regulator for the OTG port
> VBUS
>
> Signed-off-by: Brian Kim <brian.kim@hardkernel.com>

Thanks for the patch.

In the future, please state what branch the patch should apply to when
not using mainline.  Because of the sd_emmc nodes in your patch, I could
tell that it was based on my integ branch so was able to figure it out,
but it's very helpful to maintainers if you state the branch and/or any
dependencies explicity.

> ---
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 29 ++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 8d89edc..997c671 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -64,6 +64,18 @@
>  		reg = <0x0 0x0 0x0 0x80000000>;
>  	};
>  
> +	usb_pwr: regulator-usb-pwrs {

minor nit: since this is specific to the OTG part, can you call this
usb_otg_pwr? ...

> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "USB_PWR";

... and rename this also?

> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +
> +		gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +

Thanks

Kevin
