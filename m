From: david@lechnology.com (David Lechner)
Date: Tue, 17 Jan 2017 12:53:16 -0600
Subject: [PATCH v2 14/14] ARM: dts: da850-lcdk: enable the SATA node
In-Reply-To: <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
References: <1484655976-25382-1-git-send-email-bgolaszewski@baylibre.com>
 <1484655976-25382-15-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <8dae1b25-465e-faf5-b5bb-7b1f534a1bcb@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/17/2017 06:26 AM, Bartosz Golaszewski wrote:
> Enable the SATA node for da850-lcdk. We omit the pinctrl property on
> purpose - the muxed SATA pins are not hooked up to anything
> SATA-related on the lcdk.
>
> The REFCLKN/P rate on the board is 100MHz, so we need a multiplier of
> 15 for 1.5GHz PLL rate.

The multiplier is no longer in device tree, so this comment is not 
necessary.

>
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
>
