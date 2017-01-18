From: khilman@baylibre.com (Kevin Hilman)
Date: Tue, 17 Jan 2017 16:39:24 -0800
Subject: [PATCH v2 14/14] ARM: dts: da850-lcdk: enable the SATA node
In-Reply-To: <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
 (Bartosz Golaszewski's message of "Tue, 17 Jan 2017 13:26:16 +0100")
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <m2r34119s3.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bartosz Golaszewski <bgolaszewski@baylibre.com> writes:

> Enable the SATA node for da850-lcdk. We omit the pinctrl property on
> purpose - the muxed SATA pins are not hooked up to anything
> SATA-related on the lcdk.
>
> The REFCLKN/P rate on the board is 100MHz, so we need a multiplier of
> 15 for 1.5GHz PLL rate.

leftover comment from previous version?

Kevin

> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---
>  arch/arm/boot/dts/da850-lcdk.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
> index afcb482..fbeee3c 100644
> --- a/arch/arm/boot/dts/da850-lcdk.dts
> +++ b/arch/arm/boot/dts/da850-lcdk.dts
> @@ -105,6 +105,10 @@
>  	status = "okay";
>  };
>  
> +&sata {
> +	status = "okay";
> +};
> +
>  &mdio {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&mdio_pins>;
