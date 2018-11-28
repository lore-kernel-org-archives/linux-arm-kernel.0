From: shawnguo@kernel.org (Shawn Guo)
Date: Wed, 28 Nov 2018 10:39:01 +0800
Subject: [PATCH] ARM: dts: imx: Add Y Soft IOTA Draco, Hydra and Ursa
 boards
In-Reply-To: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
References: <1541086962-52626-1-git-send-email-michal.vokac@ysoft.com>
Message-ID: <20181128023859.GB20643@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 01, 2018 at 03:43:26PM +0000, Vok?? Michal wrote:
...
> +&usdhc3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usdhc3>;
> +	bus-width = <4>;
> +	cd-gpios = <&gpio7 8 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;
> +	no-1-8-v;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;

This property is deprecated.  Please use "wakeup-source" instead.

Shawn

> +	vmmc-supply = <&sw2_reg>;
> +	status = "disabled";
> +};
