From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 22 Mar 2013 10:26:23 +0100
Subject: [PATCH] ARM: mvebu: Add button on Armada 370 Reference Design
 board
In-Reply-To: <1363894988-3181-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363894988-3181-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <514C23BF.10504@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ezequiel,

Le 03/21/13 20:43, Ezequiel Garcia a ?crit :
> The Marvell Armada 370 Reference Design board has a software-controlled
> button on the front side, marked as "SW".
> This patch adds minimal support for this button.

This is also what I found out while playing with gpio exporting, looks good!

>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Acked-by: Florian Fainelli <florian@openwrt.org>

> ---
>   arch/arm/boot/dts/armada-370-rd.dts |   11 +++++++++++
>   1 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/boot/dts/armada-370-rd.dts b/arch/arm/boot/dts/armada-370-rd.dts
> index f8e4855..df3fdf4 100644
> --- a/arch/arm/boot/dts/armada-370-rd.dts
> +++ b/arch/arm/boot/dts/armada-370-rd.dts
> @@ -65,4 +65,15 @@
>   			/* No CD or WP GPIOs */
>   		};
>   	};
> +
> +	gpio-keys {
> +		compatible = "gpio-keys";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		button at 1 {
> +			label = "Software Button";
> +			linux,code = <116>;
> +			gpios = <&gpio0 6 1>;
> +		};
> +	};
>   };
>
