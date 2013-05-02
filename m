From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 2 May 2013 16:53:16 -0300
Subject: [PATCH] ARM: kirkwood: add button for OpenBlock A6
In-Reply-To: <1367523802-16372-1-git-send-email-gregory.clement@free-electrons.com>
References: <1367523802-16372-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20130502195315.GA4107@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Gregory,

On Thu, May 02, 2013 at 09:43:22PM +0200, Gregory CLEMENT wrote:
> The OpenBlocks A6 board has one software-controlled button on the
> front side, labeled "INIT", so we add minimal support for this button
> in the kernel.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
>  arch/arm/boot/dts/kirkwood-openblocks_a6.dts |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> index d27f724..627d8d0 100644
> --- a/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> +++ b/arch/arm/boot/dts/kirkwood-openblocks_a6.dts
> @@ -209,4 +209,17 @@
>  			gpios = <&gpio1 11 1>;
>  		};
>          };
> +
> +	gpio_keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +			button at 1 {
> +			label = "Init Button";
> +			linux,code = <116>;
> +			gpios = <&gpio1 6 0>;
> +		};
> +	};
> +
>  };

Shouldn't you add a proper pinctrl entry for this as well?

-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
