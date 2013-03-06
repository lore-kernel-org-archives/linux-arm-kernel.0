From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 6 Mar 2013 19:24:06 +0100
Subject: [PATCH 3/3] arm: kirkwood: add support for Init button on
 OpenBlocks A6
In-Reply-To: <1362587021-32762-4-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1362587021-32762-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1362587021-32762-4-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130306182406.GG3904@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 06, 2013 at 05:23:41PM +0100, Thomas Petazzoni wrote:
> The Kirkwood-based PlatHome OpenBlocks A6 board has an Init button
> connected to MPP pin 38. This commit adds support for this button.
> 
> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> index 0488d6a..7ac831e 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> @@ -172,4 +172,18 @@
>  			gpios = <&gpio1 11 1>;
>  		};
>          };
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		pinctrl-0 = <&pmx_gpio_init>;
> +		pinctrl-names = "default";

Hi Thomas

I know i'm repeating myself.....

pinctrl* are not needed.

    Andrew

> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		button at 1 {
> +			label = "Init Button";
> +			linux,code = <116>;
> +			gpios = <&gpio1 6 0>;
> +		};
> +	};
>  };
> -- 
> 1.7.9.5
> 
