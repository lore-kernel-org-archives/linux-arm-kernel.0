From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 05 Jul 2013 12:43:05 -0600
Subject: [PATCH] ARM: tegra: enable gpio-keys on dalmore
In-Reply-To: <1373028111-24246-1-git-send-email-ldewangan@nvidia.com>
References: <1373028111-24246-1-git-send-email-ldewangan@nvidia.com>
Message-ID: <51D713B9.40205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/05/2013 06:41 AM, Laxman Dewangan wrote:
> Dalmore have the keys mounted on board which are connected
> to different pins of Tegra.
> 
> Add the keys entry in DTS file to enable key functionality.
> This will enable KEY_POWER, KEY_HOME, KEY_VOLUMEUP and
> KEY_VOLUMEDOWN.

> diff --git a/arch/arm/boot/dts/tegra114-dalmore.dts b/arch/arm/boot/dts/tegra114-dalmore.dts

>  			 <&tegra_car TEGRA114_CLK_EXTERN1>;
>  		clock-names = "pll_a", "pll_a_out0", "mclk";
>  	};
> +
> +	gpio-keys {

The node above is "sound". This node should be before that node so
they're alphabetically sorted.

> +		compatible = "gpio-keys";
> +
> +		power {
> +			label = "Power";
> +			gpios = <&gpio TEGRA_GPIO(Q, 0) GPIO_ACTIVE_LOW>;
> +			linux,code = <116>; /* KEY_POWER */
> +			gpio-key,wakeup;
> +		};
> +
> +		home {

Similarly, the nodes inside gpio-keys should also be sorted alphabetically.
